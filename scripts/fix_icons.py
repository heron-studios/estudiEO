import os
import re

subjects = {
    'ciencias_sociales': '🌍',
    'comunicacion': '📖',
    'cta': '🔬',
    'matematicas': '📐',
    'pfrh': '🤝',
    'rm': '🧩',
    'rv': '📝'
}

base_path = r'C:\Users\PC\Downloads\EDUPOL-flutter\lib\data\library'

for subj, icon in subjects.items():
    file_path = os.path.join(base_path, subj, f'{subj}_subject.dart')
    if os.path.exists(file_path):
        with open(file_path, 'r', encoding='utf-8') as f:
            content = f.read()
        
        # Replace the icon line, ensuring we match whatever mojibake is there
        new_content = re.sub(r"icon:\s*'.*?',", f"icon: '{icon}',", content)
        
        if new_content != content:
            with open(file_path, 'w', encoding='utf-8') as f:
                f.write(new_content)
            print(f'Updated {subj}')
        else:
            print(f'No change for {subj}')
    else:
        print(f'File not found: {file_path}')
