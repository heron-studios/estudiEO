import os
import re

lib_path = r'c:\Users\PC\Downloads\EstudiEO-flutter\lib'

def process_file(filepath):
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()

    # Navigator.pushNamed(context, '/route') -> context.push('/route')
    # Navigator.pushNamed(context, '/route', arguments: ...) -> context.push('/route', extra: ...)
    # Navigator.pushReplacementNamed(...) -> context.replace(...)

    original_content = content

    content = re.sub(
        r'Navigator\.pushNamed\s*\(\s*context\s*,\s*([^,)]+)\s*\)',
        r'context.push(\1)',
        content
    )
    content = re.sub(
        r'Navigator\.pushNamed\s*\(\s*context\s*,\s*([^,)]+)\s*,\s*arguments\s*:\s*([^)]+)\)',
        r'context.push(\1, extra: \2)',
        content
    )
    content = re.sub(
        r'Navigator\.pushReplacementNamed\s*\(\s*context\s*,\s*([^,)]+)\s*\)',
        r'context.replace(\1)',
        content
    )
    content = re.sub(
        r'Navigator\.pushReplacementNamed\s*\(\s*context\s*,\s*([^,)]+)\s*,\s*arguments\s*:\s*([^)]+)\)',
        r'context.replace(\1, extra: \2)',
        content
    )

    if content != original_content:
        # Add import if missing
        if 'package:go_router/go_router.dart' not in content:
            # add it after the last import
            imports = re.findall(r"^import\s+['\"].+?['\"];", content, re.MULTILINE)
            if imports:
                last_import = imports[-1]
                content = content.replace(last_import, last_import + "\nimport 'package:go_router/go_router.dart';")
        
        with open(filepath, 'w', encoding='utf-8') as f:
            f.write(content)
        print(f"Modified {filepath}")

for root, _, files in os.walk(lib_path):
    for f in files:
        if f.endswith('.dart'):
            process_file(os.path.join(root, f))
