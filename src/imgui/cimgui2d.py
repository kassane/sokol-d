#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""Generate D bindings for cimgui from C header files.

Based on https://floooh.github.io/2020/08/23/sokol-bindgen.html
License: MIT-0
"""
import subprocess
import json
import os
from datetime import date
from dataclasses import dataclass
from typing import Dict, List, Set, Optional, Tuple

@dataclass
class TypeMapper:
    """Maps C types to D types."""
    struct_names: Set[str]
    callback_aliases: Dict[str, str] = None

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

    def __post_init__(self):
        self.callback_aliases = self.callback_aliases or {}

    def clean(self, qual_type: str, is_callback: bool = False, is_param: bool = False, is_output: bool = False) -> str:
        """Convert C type to D type, ensuring correct pointer and const placement."""
        if '(*)' in qual_type:
            ret_type, params = self._parse_function_pointer(qual_type)
            param_str = ', '.join(self.clean(p, is_callback=True, is_param=True) for p in params)
            return f"{ret_type} function({param_str})"

        # Parse qualifiers and base type
        is_const = qual_type.startswith('const ')
        stripped = qual_type.replace('const ', '').strip()
        pointer_level = stripped.count('*')
        base_type = stripped.rstrip('*').strip()

        # Map base type
        d_type = self._type_map.get(base_type, f"{base_type}_t" if base_type in self.struct_names else base_type)

        # Apply pointer and const
        if pointer_level:
            # Special case for char pointers: use 'const(char)*' for const char pointers
            if base_type == 'char' and is_const:
                d_type = f"const(char){'*' * pointer_level}"
            # Special case for specific types: force scope T* despite const in C
            elif (is_param and base_type in {'ImVec2', 'ImGuiTreeNodeStackData', 'ImGuiErrorRecoveryState', 
                                            'ImDrawList', 'ImFontGlyph', 'ImFontAtlasRect', 'ImDrawCmd'} and not is_output):
                d_type = f"scope {d_type}{'*' * pointer_level}"
            else:
                if is_const and not is_output:
                    d_type = f"const({d_type}){'*' * pointer_level}"
                else:
                    d_type = f"{d_type}{'*' * pointer_level}"
        elif is_const:
            d_type = f"const({d_type})"

        # Add scope for non-callback, non-output pointer parameters, except for special cases
        if (is_param and pointer_level and not is_callback and not is_output and 
                d_type not in self.callback_aliases and not d_type.startswith('scope ') and not d_type.startswith('const(char)')):
            d_type = f"scope {d_type}"

        return d_type

    def _parse_function_pointer(self, qual_type: str) -> Tuple[str, List[str]]:
        """Extract return type and parameters from function pointer type."""
        parts = qual_type.split('(*)')
        if len(parts) != 2:
            return self.clean(parts[0].strip()), []
        ret_type = self.clean(parts[0].strip())
        params = [p.strip() for p in parts[1].strip('()').split(',') if p.strip()]
        return ret_type, params

def run_clang(header_path: str) -> Dict:
    """Generate AST in JSON format from C header."""
    cmd = ['clang', '-Xclang', '-ast-dump=json', '-c', header_path, '-fparse-all-comments']
    try:
        output = subprocess.check_output(cmd, stderr=subprocess.STDOUT, text=True)
        return json.loads(output)
    except subprocess.CalledProcessError as e:
        raise RuntimeError(f"Clang error: {e.output}") from e

def extract_comment(node: Dict, source: str) -> Optional[str]:
    """Extract and format comment from AST node as D /++ +/ block."""
    if node.get('kind') != 'FunctionDecl':
        return None

    for child in node.get('inner', []):
        if child.get('kind') != 'FullComment':
            continue
        parts = []
        for inner in child.get('inner', []):
            if inner.get('kind') == 'ParagraphComment':
                text = ''.join(n.get('text', '').strip() + '\n' for n in inner.get('inner', []) if n.get('kind') == 'TextComment').strip()
                if text:
                    # Split by newlines, remove '-', and preserve empty lines
                    lines = text.split('\n')
                    formatted_lines = [line.replace('-', '') if line.strip() else '' for line in lines]
                    parts.append('\n'.join(formatted_lines))
            elif inner.get('kind') in ('BlockTextComment', 'BlockCommandComment'):
                if text := inner.get('text', '').strip():
                    # Remove '-' in block comments
                    parts.append(text.replace('-', ''))
            elif inner.get('kind') == 'ParamCommandComment':
                if param_text := f"param {inner.get('param', '')}: {inner.get('text', '').strip()}".strip():
                    # Remove '-' in param comments
                    parts.append(param_text.replace('-', ''))
        if parts:
            # Ensure each line (including empty ones) starts with '+' and add empty '+' line between parts
            formatted_parts = []
            for part in parts:
                lines = part.split('\n')
                formatted_lines = [f"+ {line}" if line.strip() else "+" for line in lines]
                formatted_parts.append('\n'.join(formatted_lines))
            return f"/++\n{'\n+\n'.join(formatted_parts)}\n+/"
    return None

def collect_struct_names(ast: Dict) -> Set[str]:
    """Collect all struct names from AST."""
    return {node['name'] for node in _traverse_ast(ast, 'RecordDecl') if 'name' in node}

def collect_callbacks(ast: Dict, mapper: TypeMapper) -> None:
    """Collect function pointer types for callbacks."""
    for node in _traverse_ast(ast, 'FunctionDecl'):
        for param in node.get('inner', []):
            if param.get('kind') == 'ParmVarDecl' and '(*)' in param['type']['qualType']:
                param_name = param.get('name', f"arg{len(mapper.callback_aliases)}")
                func_type = mapper.clean(param['type']['qualType'], is_callback=True)
                alias_name = f"ImGui{param_name[0].upper()}{param_name[1:]}Callback" if param_name != f"arg{len(mapper.callback_aliases)}" else f"ImGuiCallback{len(mapper.callback_aliases)}"
                mapper.callback_aliases[alias_name] = func_type

def _traverse_ast(node: Dict, kind: str) -> List[Dict]:
    """Yield nodes of specified kind from AST."""
    if node.get('kind') == kind:
        yield node
    for child in node.get('inner', []):
        yield from _traverse_ast(child, kind)

def generate_function(node: Dict, source: str, mapper: TypeMapper) -> Optional[Dict]:
    """Generate D function declaration or alias."""
    if node.get('kind') != 'FunctionDecl' or 'name' not in node:
        return None

    name = node['name']
    return_type = mapper.clean(node['type']['qualType'].split('(')[0].strip())
    params = []
    d_keywords = {'in', 'out', 'ref', 'interface', 'align'}
    has_args_param = False
    has_fmt_param = False

    # Functions where scope is avoided for pointer parameters or that return pointer params
    no_scope_functions = {
        'igIsMousePosValid',
        'igAddContextHook',
        'igAddSettingsHandler',
        'igLocalizeRegisterEntries',
        'igItemAddEx',
        'igLogRenderedText',
        'igLogRenderedTextEx',
        'igNavMoveRequestResolveWithPastTreeNode',
        'igGetColumnOffsetFromNorm',
        'igGetColumnNormFromOffset',
        'igTableAngledHeadersRowEx',
        'igTableGetCellBgRect',
        'igTableGetColumnNameImGuiTablePtr',
        'igTableCalcMaxColumnWidth',
        'igRenderTextClipped',
        'igRenderTextClippedEx',
        'igRenderTextClippedWithDrawList',
        'igRenderTextClippedWithDrawListEx',
        'igRenderTextEllipsis',
        'igAcceptDragDropPayload',  # Returns pointer, avoid scope
        'igFindWindowByName',  # Returns pointer, avoid scope
        'igFindSettingsHandler',  # Returns pointer, avoid scope
        'igCreateNewWindowSettings',  # Returns pointer, avoid scope
        'igFindRenderedTextEnd',  # Returns pointer, avoid scope
        'igFindRenderedTextEndEx'  # Returns pointer, avoid scope
    }
    output_param_functions = {
        'igAddContextHook',
        'igAddSettingsHandler',
        'igLocalizeRegisterEntries',
        'igItemAddEx',
        'igLogRenderedText',
        'igLogRenderedTextEx',
        'igNavMoveRequestResolveWithPastTreeNode',
        'igGetColumnOffsetFromNorm',
        'igGetColumnNormFromOffset',
        'igTableAngledHeadersRowEx',
        'igTableGetCellBgRect',
        'igTableGetColumnNameImGuiTablePtr',
        'igTableCalcMaxColumnWidth',
        'igRenderTextClipped',
        'igRenderTextClippedEx',
        'igRenderTextClippedWithDrawList',
        'igRenderTextClippedWithDrawListEx',
        'igRenderTextEllipsis',
        'igAcceptDragDropPayload',  # Has output parameters
        'igSaveIniSettingsToMemory'  # Has output parameters
    }
    output_param_names = set()
    if name in output_param_functions:
        for i, param in enumerate(node.get('inner', [])):
            if param.get('kind') != 'ParmVarDecl':
                continue
            param_type_raw = param['type']['qualType']
            param_name = param.get('name', f"arg{i}")
            # Mark parameters as output if they lack 'const' in C declaration
            if '*' in param_type_raw and not param_type_raw.startswith('const '):
                output_param_names.add(param_name)

    for i, param in enumerate(node.get('inner', [])):
        if param.get('kind') != 'ParmVarDecl':
            continue
        param_type_raw = param['type']['qualType']
        is_callback = '(*)' in param_type_raw
        param_name = param.get('name', f"arg{i}")
        is_output = param_name in output_param_names or name in no_scope_functions
        param_type = mapper.clean(param_type_raw, is_callback=is_callback, is_param=True, is_output=is_output)
        if param_name == 'args':
            has_args_param = True
        if param_name == 'fmt':
            has_fmt_param = True
        if is_callback:
            if alias_name := next((k for k, v in mapper.callback_aliases.items() if v == param_type), None):
                param_type = alias_name
        if param_name in d_keywords:
            param_name += '_'
        params.append(f"{param_type} {param_name}")

    param_call = ', '.join(p.split()[-1] for p in params)
    # Generate alias for functions ending with V, VPtr, or starting with Text, if they have args or fmt param
    decl = [f"alias {name[2:]} = {name};"] if ((name.endswith('V') or name.endswith('VPtr') and has_args_param) or (name.startswith('igText') and has_fmt_param)) else \
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
    """Generate D wrapper code."""
    comment_lines = [
        "+ D wrapper for cimgui (Dear ImGui).",
        "+ Provides bindings for Dear ImGui immediate mode GUI library.",
        "+",
        "+ Features:",
        "+   Full ImGui API coverage",
        "+   @trusted wrapper functions",
        "+   Preserves ImGui naming conventions",
        "+   Handles memory management",
    ]
    output = [
        f"// Generated on {date.today()}",
        "/++",
        *comment_lines,
        "+/",
        "module imgui.cimgui;",
        "public import imgui.c.dcimgui;",
        "\npure @nogc nothrow:\n"
    ]

    if callback_aliases:
        output.append("// Callback function types")
        for alias_name, func_type in sorted(callback_aliases.items()):
            output.append(f"extern(C) alias {alias_name} = {func_type};")
        output.append("")

    output.append("// D-friendly wrappers")
    for func in functions:
        if not func['name'].startswith('ig'):
            continue
        wrapper_name = func['name'][2:]
        is_alias = func['decl'][0].startswith('alias')
        if func['comment']:
            output.append(func['comment'])
        if is_alias:
            output.append(f"alias {wrapper_name} = {func['name']};")
        else:
            output.extend([
                f"{func['return_type']} {wrapper_name}({', '.join(func['params'])}) @trusted",
                "{",
                f"    {'return ' if func['return_type'] != 'void' else ''}{func['name']}({func['param_call']});",
                "}"
            ])
        output.append("")

    return "\n".join(output)

def main():
    """Generate D bindings from cimgui header."""
    header_path = '../../vendor/imgui/src/cimgui_all.h'
    output_path = 'cimgui.d'

    try:
        if not os.path.exists(header_path):
            raise FileNotFoundError(f"Header file not found: {header_path}")

        with open(header_path, 'r', encoding='utf-8') as f:
            source = f.read()

        print("Generating AST...")
        ast = run_clang(header_path)

        print("Generating D code...")
        mapper = TypeMapper(collect_struct_names(ast))
        collect_callbacks(ast, mapper)
        functions = []
        for node in _traverse_ast(ast, 'FunctionDecl'):
            if func := generate_function(node, source, mapper):
                functions.append(func)
        d_code = generate_d_code(functions, mapper.callback_aliases)

        print(f"Writing {output_path}...")
        with open(output_path, 'w', encoding='utf-8') as f:
            f.write(d_code)

        print("Done!")
    except Exception as e:
        print(f"Error: {e}")
        exit(1)

if __name__ == "__main__":
    main()