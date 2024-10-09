#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# Based on https://floooh.github.io/2020/08/23/sokol-bindgen.html
# license: MIT-0

import subprocess
import json
import os
import datetime

def clang(csrc_path):
    """Generate an AST in JSON format from the C header, including comments."""
    cmd = ['clang', '-Xclang', '-ast-dump=json', '-c', csrc_path, '-fparse-all-comments']
    try:
        output = subprocess.check_output(cmd, stderr=subprocess.STDOUT)
        return json.loads(output)
    except subprocess.CalledProcessError as e:
        print(f"Clang error: {e.output.decode()}")
        raise

def clean_type(qual_type, struct_names, callback_aliases, is_callback_param=False):
    """Convert C types to D-compatible types, applying const only when present and avoiding scope for callbacks."""
    # Handle function pointers
    if '(*)' in qual_type:
        parts = qual_type.split('(*)')
        ret_type = clean_type(parts[0].strip(), struct_names, callback_aliases, is_callback_param)
        param_part = parts[1].strip('()')
        params = [clean_type(p.strip(), struct_names, callback_aliases, is_callback_param=True) for p in param_part.split(',')]
        param_str = ', '.join(params)
        return f"{ret_type} function({param_str})"
    
    # Check if type has const
    is_const = qual_type.startswith('const ')
    stripped_type = qual_type.replace('const ', '').strip()
    
    # Special case for va_list
    if stripped_type == 'struct __va_list_tag *':
        return '__builtin_va_list'
    
    # Split into base type and pointer level
    pointer_level = stripped_type.count('*')
    base_type = stripped_type.replace('*', '').strip()
    
    # Type mapping
    type_map = {
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
    
    # Convert base type
    converted_base = type_map.get(base_type, base_type)
    
    # Handle structs
    if base_type in struct_names:
        converted_base = f"{base_type}_t"
    
    # Reassemble type
    if pointer_level > 0:
        # Apply const only if present in C
        if is_const:
            d_type = f"const({converted_base}){'*' * pointer_level}"
        else:
            d_type = f"{converted_base}{'*' * pointer_level}"
    else:
        d_type = converted_base
    
    # Add scope for DIP1000, but not for function pointers, callback aliases, or callback parameters
    if (pointer_level > 0 and 
        'function' not in d_type and 
        not any(d_type == alias_name for alias_name in callback_aliases) and 
        not is_callback_param):
        d_type = f'scope {d_type}'
    
    return d_type

def get_comments(node, ast):
    """Extract comments associated with a node based on source offset."""
    if 'loc' not in node or 'file' not in node['loc']:
        return []
    node_offset = node['loc'].get('offset', 0)
    comments = []
    
    for n in ast.get('inner', []):
        if n['kind'] == 'FullComment' and 'loc' in n and 'file' in n['loc']:
            comment_offset = n['loc'].get('offset', 0)
            if comment_offset < node_offset:
                comment_text = ''
                for inner in n.get('inner', []):
                    if inner['kind'] == 'ParagraphComment':
                        for text in inner.get('inner', []):
                            if text['kind'] == 'TextComment':
                                comment_text += text['text'].strip() + '\n'
                if comment_text:
                    comments.append(comment_text.strip())
    return comments

def format_comments(comments):
    """Format comments into D-friendly // style."""
    formatted = []
    for comment in comments:
        lines = comment.split('\n')
        for line in lines:
            if line.strip():
                formatted.append(f"// {line.strip()}")
    return formatted

def generate_struct(node, ast, struct_names, callback_aliases):
    """Generate D struct definition with comments."""
    if node['kind'] != 'RecordDecl' or 'name' not in node:
        return None
    struct_name = node['name']
    fields = []
    comments = get_comments(node, ast)
    
    for child in node.get('inner', []):
        if child['kind'] == 'FieldDecl' and 'name' in child:
            field_comments = get_comments(child, ast)
            if field_comments:
                fields.extend(format_comments(field_comments))
            field_type = clean_type(child['type']['qualType'], struct_names, callback_aliases)
            field_name = child['name']
            fields.append(f"    {field_type} {field_name};")
    
    decl = [f"struct {struct_name}", "{"] + fields + ["}"] if fields else [f"struct {struct_name} {{}}"]
    return {'comments': comments, 'decl': decl, 'name': struct_name}

def generate_function(node, ast, struct_names, callback_aliases):
    """Generate D function declaration with callback aliases."""
    if node['kind'] != 'FunctionDecl' or 'name' not in node:
        return None
    
    func_name = node['name']
    return_type = clean_type(node['type']['qualType'].split('(')[0].strip(), struct_names, callback_aliases)
    params = []
    d_keywords = {'in', 'out', 'ref', 'interface'}
    
    for i, param in enumerate(node.get('inner', [])):
        if param['kind'] == 'ParmVarDecl':
            param_type = clean_type(param['type']['qualType'], struct_names, callback_aliases)
            param_name = param.get('name', f"arg{i}")
            
            # Handle function pointer parameters
            if 'function' in param_type:
                alias_name = f"ImGui{param_name[0].upper()}{param_name[1:]}Func" if param_name and param_name != f"arg{i}" else f"ImGuiCallback{i}Func"
                if alias_name not in callback_aliases:
                    callback_aliases[alias_name] = param_type
                param_type = alias_name
            
            # Handle D keywords
            if param_name in d_keywords:
                param_name += "_"
            
            params.append(f"{param_type} {param_name}")
    
    param_str = ", ".join(params) if params else ""
    comments = get_comments(node, ast)
    decl = [f"{return_type} {func_name}({param_str}) @trusted;"]
    
    return {
        'comments': format_comments(comments),
        'decl': decl,
        'name': func_name,
        'params': params,
        'return_type': return_type
    }

def collect_struct_names(ast):
    """Collect all struct names from the AST."""
    struct_names = set()
    def traverse(node):
        if node['kind'] == 'RecordDecl' and 'name' in node:
            struct_names.add(node['name'])
        for child in node.get('inner', []):
            traverse(child)
    traverse(ast)
    return struct_names

def generate_dlang_wrapper(ast):
    """Generate complete D wrapper with callback aliases."""
    struct_names = collect_struct_names(ast)
    functions = []
    structs = []
    callback_aliases = {}
    
    def traverse(node):
        if node['kind'] == 'FunctionDecl':
            func = generate_function(node, ast, struct_names, callback_aliases)
            if func:
                functions.append(func)
        elif node['kind'] == 'RecordDecl':
            struct = generate_struct(node, ast, struct_names, callback_aliases)
            if struct:
                structs.append(struct)
        for child in node.get('inner', []):
            traverse(child)
    
    traverse(ast)
    
    output = [
        f"// Generated on {datetime.date.today()}",
        "/++",
        "This is a D wrapper around the cimgui library (Dear ImGui).",
        "It provides D bindings for the Dear ImGui immediate mode GUI library.",
        "",
        "Features:",
        "- Full ImGui API coverage",
        "- @trusted wrapper functions",
        "- Preserves ImGui's original style and naming conventions",
        "- Handles memory management and context safety",
        "+/",
        "module imgui;",
        "version (has_imgui)",
        "{",
        "public import imgui.dcimgui;",
        "\n@nogc nothrow:\n",
    ]
    
    # Add callback aliases
    if callback_aliases:
        output.append("// Callback function types")
        for alias_name, func_type in callback_aliases.items():
            output.append(f"extern(C) alias {alias_name} = {func_type};")
        output.append("")
    
    # Add extern(D) wrappers
    output.append("// D-friendly wrappers")
    
    for func in functions:
        if func['name'].startswith('ig'):
            wrapper_name = func['name'][2:]
            param_names = [p.split()[-1] for p in func['params']]
            param_call = ", ".join(param_names) if param_names else ""
            if func['comments']:
                output.extend(func['comments'])
            output.append(f"{func['return_type']} {wrapper_name}({', '.join(func['params'])}) @trusted")
            output.append("{")
            if func['return_type'] != 'void':
                output.append(f"    return {func['name']}({param_call});")
            else:
                output.append(f"    {func['name']}({param_call});")
            output.append("}")
            output.append("")
    
    output.append("}")
    return "\n".join(output)

def main():
    """Main function to generate D bindings."""
    try:
        local_path = '../vendor/dcimgui/src/cimgui.h'
        if not os.path.exists(local_path):
            raise FileNotFoundError(f"Header file not found at {local_path}")
        
        print("Generating AST...")
        ast = clang(local_path)
        
        print("Generating D code...")
        d_code = generate_dlang_wrapper(ast)
        
        print("Writing cimgui.d...")
        with open('cimgui.d', 'w') as f:
            f.write(d_code)
        
        print("Done!")
    except Exception as e:
        print(f"Error: {e}")

if __name__ == "__main__":
    main()

