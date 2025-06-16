#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""Generate D bindings for cimgui from C header files.

Based on https://floooh.github.io/2020/08/23/sokol-bindgen.html
License: MIT-0
"""
import subprocess
import json
import os
import datetime
from dataclasses import dataclass
from typing import Dict, List, Set, Optional, Tuple

@dataclass
class TypeMapper:
    """Maps C types to D-compatible types."""
    struct_names: Set[str]
    callback_aliases: Dict[str, str]
    
    _type_map = {
        'char': 'char',
        'unsigned short': 'ushort',
        'unsigned int': 'uint',
        'unsigned char': 'ubyte',
        'int': 'int',
        'float': 'float',
        'void': 'void',
        'double': 'double',
        'bool': 'bool',
        'size_t': 'size_t'
    }
    
    def clean(self, qual_type: str, is_callback: bool = False) -> str:
        """Convert C type to D type, ensuring const(T)* for C const pointers."""
        if '(*)' in qual_type:
            ret_type, params = self._parse_function_pointer(qual_type)
            param_str = ', '.join(self.clean(p.strip(), is_callback=True) for p in params)
            return f"{ret_type} function({param_str})"
        
        is_const = qual_type.startswith('const ')
        stripped = qual_type.replace('const ', '').strip()
        pointer_level = stripped.count('*')
        base_type = stripped.replace('*', '').strip()
        
        converted_base = self._type_map.get(base_type, base_type)
        if base_type in self.struct_names:
            converted_base = f"{base_type}_t"
        
        if is_const and pointer_level:
            d_type = f"const({converted_base}){'*' * pointer_level}"
        elif pointer_level:
            d_type = f"{converted_base}{'*' * pointer_level}"
        elif is_const:
            d_type = f"const({converted_base})"
        else:
            d_type = converted_base
        
        # Add scope only for non-callback, non-function pointers
        if pointer_level and 'function' not in d_type and not is_callback:
            d_type = f'scope {d_type}'
        
        return d_type
    
    def _parse_function_pointer(self, qual_type: str) -> Tuple[str, List[str]]:
        """Extract return type and parameters from function pointer type."""
        parts = qual_type.split('(*)')
        if len(parts) != 2:
            return self.clean(parts[0].strip()), []
        
        ret_type = self.clean(parts[0].strip())
        params = [p.strip() for p in parts[1].strip('()').split(',') if p.strip()]
        return ret_type, params

def run_clang(csrc_path: str, source: str) -> Dict:
    """Generate AST in JSON format from C header."""
    cmd = ['clang', '-Xclang', '-ast-dump=json', '-c', csrc_path, '-fparse-all-comments']
    try:
        output = subprocess.check_output(cmd, stderr=subprocess.STDOUT)
        return json.loads(output)
    except subprocess.CalledProcessError as e:
        raise RuntimeError(f"Clang error: {e.output.decode()}")

def extract_comment(node: Dict, source: str) -> Optional[str]:
    """Extract comment from AST, converting to a single /++ +/ block."""
    def process_comment(comment_node: Dict) -> Optional[str]:
        """Process a FullComment node and its children."""
        if comment_node.get('kind') != 'FullComment':
            return None
        parts = []
        for child in comment_node.get('inner', []):
            if child.get('kind') == 'ParagraphComment':
                text = ''
                for text_node in child.get('inner', []):
                    if text_node.get('kind') == 'TextComment':
                        text += text_node.get('text', '').strip() + ' '
                if text.strip():
                    parts.append(text.strip())
            elif child.get('kind') in ('BlockTextComment', 'BlockCommandComment'):
                text = child.get('text', '').strip()
                if text:
                    parts.append(text)
            elif child.get('kind') == 'ParamCommandComment':
                param_text = f"param {child.get('param', '')}: {child.get('text', '').strip()}"
                if param_text.strip():
                    parts.append(param_text)
        if parts:
            return f"/++\n{'\n'.join(parts).rstrip()}\n+/"
        return None

    # Look for FullComment node directly associated with the declaration
    for child in node.get('inner', []):
        if child.get('kind') == 'FullComment':
            return process_comment(child)
    
    # Fallback: Check for comments via source range, but only for function declarations
    if node.get('kind') != 'FunctionDecl' or 'range' not in node or 'begin' not in node['range']:
        return None
    begin, end = node['range']['begin'].get('offset', 0), node['range']['end'].get('offset', 0)
    if begin >= end:
        return None
    
    # Extract single-line comments (/// or //) before the declaration
    pos = begin
    lines = []
    while pos > 0:
        prev_text = source[:pos].rstrip()
        if not prev_text:
            break
        prev_line_end = prev_text.rfind('\n') + 1
        prev_line = prev_text[prev_line_end:].strip()
        if not (prev_line.startswith('///') or prev_line.startswith('//')):
            break
        comment_text = prev_line[3 if prev_line.startswith('///') else 2:].strip()
        if comment_text:
            lines.insert(0, comment_text)
        pos = prev_line_end - 1
    if lines:
        return f"/++\n{' '.join(lines)}\n+/"
    
    return None

def collect_struct_names(ast: Dict) -> Set[str]:
    """Yield all struct names from AST."""
    def traverse(node: Dict):
        if node.get('kind') == 'RecordDecl' and 'name' in node:
            yield node['name']
        for child in node.get('inner', []):
            yield from traverse(child)
    return set(traverse(ast))

def generate_decls(ast: Dict, source: str, mapper: TypeMapper) -> List[Dict]:
    """Generate D declarations for functions."""
    functions = []
    
    def traverse(node: Dict):
        if node.get('kind') == 'FunctionDecl':
            func = generate_function(node, source, mapper)
            if func:
                functions.append(func)
        for child in node.get('inner', []):
            traverse(child)
    
    traverse(ast)
    return functions

def generate_function(node: Dict, source: str, mapper: TypeMapper) -> Optional[Dict]:
    """Generate D function declaration or alias for functions ending with 'V' or 'VPtr' with 'args' param."""
    if node.get('kind') != 'FunctionDecl' or 'name' not in node:
        return None
    name = node['name']
    return_type = mapper.clean(node['type']['qualType'].split('(')[0].strip())
    params = []
    d_keywords = {'in', 'out', 'ref', 'interface'}
    has_args_param = False
    
    for i, param in enumerate(node.get('inner', [])):
        if param.get('kind') == 'ParmVarDecl':
            param_type = mapper.clean(param['type']['qualType'])
            param_name = param.get('name', f"arg{i}")
            if param_name == 'args':
                has_args_param = True
            if 'function' in param_type:
                alias_name = f"ImGui{param_name[0].upper()}{param_name[1:]}Callback" if param_name != f"arg{i}" else f"ImGuiCallback{i}"
                if alias_name not in mapper.callback_aliases:
                    mapper.callback_aliases[alias_name] = param_type
                param_type = alias_name
            if param_name in d_keywords:
                param_name += '_'
            params.append(f"{param_type} {param_name}")
    
    param_names = [p.split()[-1] for p in params]
    param_call = ', '.join(param_names) if param_names else ''
    decl = [f"alias {name[2:]} = {name};"] if (name.endswith('V') or name.endswith('VPtr') or name.startswith('Text')) and has_args_param else \
           [f"{return_type} {name}({', '.join(params)}) @trusted;"]
    
    return {
        'comment': extract_comment(node, source),
        'decl': decl,
        'name': name,
        'params': params,
        'return_type': return_type,
        'param_call': param_call
    }

def generate_d_code(functions: List[Dict], callback_aliases: Dict[str, str]) -> str:
    """Generate D wrapper code with only wrapper functions and aliases."""
    output = [
        f"// Generated on {datetime.date.today()}",
        "/++",
        "D wrapper for cimgui (Dear ImGui).",
        "Provides bindings for Dear ImGui immediate mode GUI library.",
        "",
        "Features:",
        "- Full ImGui API coverage",
        "- @trusted wrapper functions",
        "- Preserves ImGui naming conventions",
        "- Handles memory management",
        "+/",
        "module imgui.cimgui;",
        "public import imgui.c.dcimgui;",
        "\npure @nogc nothrow:\n"
    ]
    
    if callback_aliases:
        output.append("// Callback function types")
        mapper = TypeMapper(struct_names=set(), callback_aliases=callback_aliases)
        for alias_name, func_type in callback_aliases.items():
            output.append(f"extern(C) alias {alias_name} = {mapper.clean(func_type, is_callback=True)};")
        output.append("")
    
    output.append("// D-friendly wrappers")
    for func in functions:
        if func['name'].startswith('ig'):
            wrapper_name = func['name'][2:]
            is_alias = func['decl'][0].startswith('alias')
            if func['comment']:
                output.append(func['comment'])
            if is_alias:
                output.append(f"alias {wrapper_name} = {func['name']};")
            else:
                output.append(f"{func['return_type']} {wrapper_name}({', '.join(func['params'])}) @trusted")
                output.append("{")
                if func['return_type'] != 'void':
                    output.append(f"    return {func['name']}({func['param_call']});")
                else:
                    output.append(f"    {func['name']}({func['param_call']});")
                output.append("}")
            output.append("")
    
    return "\n".join(output)

def main():
    """Generate D bindings from cimgui header."""
    header_path = '../../vendor/imgui/src/cimgui.h'
    output_path = 'cimgui.d'
    
    try:
        if not os.path.exists(header_path):
            raise FileNotFoundError(f"Header file not found at {header_path}")
        
        with open(header_path, 'r', newline='') as f:
            source = f.read()
        
        print("Generating AST...")
        ast = run_clang(header_path, source)
        
        print("Generating D code...")
        mapper = TypeMapper(collect_struct_names(ast), {})
        functions = generate_decls(ast, source, mapper)
        d_code = generate_d_code(functions, mapper.callback_aliases)
        
        print(f"Writing {output_path}...")
        with open(output_path, 'w') as f:
            f.write(d_code)
        
        print("Done!")
    except Exception as e:
        print(f"Error: {e}")
        exit(1)

if __name__ == "__main__":
    main()