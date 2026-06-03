import os

fixes = {
    'Ã¡': 'á',
    'Ã©': 'é',
    'Ã\xad': 'í',  # Ã and \xad (soft hyphen) usually corresponds to í, or Ã­
    'Ã³': 'ó',
    'Ãº': 'ú',
    'Ã±': 'ñ',
    'Ã\x81': 'Á',
    'Ã\x89': 'É',
    'Ã\x8d': 'Í',
    'Ã\x93': 'Ó',
    'Ã\x9a': 'Ú',
    'Ã\x91': 'Ñ',
    'Â¿': '¿',
    'Â¡': '¡',
    'Ã¼': 'ü',
    'Ã\x9c': 'Ü',
    'fcilmente': 'fácilmente',
    '': 'á',  # Or other depending on context
}

def fix_file(path):
    with open(path, 'r', encoding='utf-8', errors='replace') as f:
        text = f.read()
    
    # Specifically fix the known broken words
    text = text.replace('fcilmente', 'fácilmente')
    text = text.replace('lmite', 'límite')
    text = text.replace('ltimo', 'último')
    text = text.replace('Lgica', 'Lógica')
    text = text.replace('pblico', 'público')
    text = text.replace('reaccin', 'reacción')
    text = text.replace('S', 'Sí')
    text = text.replace('Ms', 'Más')
    text = text.replace('ms', 'más')
    text = text.replace('autnomo', 'autónomo')
    text = text.replace('tensin', 'tensión')
    text = text.replace('presin', 'presión')
    
    for bad, good in fixes.items():
        text = text.replace(bad, good)
        
    # Also handle the case where Ã is followed by nothing because of broken parsing
    
    with open(path, 'w', encoding='utf-8') as f:
        f.write(text)

files = [
    'C:/Users/PC/Downloads/EstudiEO-flutter/assets/data/preguntas.json',
    'C:/Users/PC/Downloads/EstudiEO-flutter/assets/data/new_preguntas.json',
    'C:/Users/PC/Downloads/EstudiEO-flutter/assets/data/new_preguntas2.json'
]

for f in files:
    if os.path.exists(f):
        fix_file(f)
