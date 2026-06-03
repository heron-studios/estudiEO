import json

parts = [
    'assets/data/preguntas_1_50.json',
    'assets/data/preguntas_51_100.json',
    'assets/data/preguntas_101_150.json',
    'assets/data/preguntas_151_200.json',
    'assets/data/preguntas_201_250.json',
    'assets/data/preguntas_251_300.json'
]

def load_part(path):
    with open(path, 'r', encoding='utf-8') as f:
        content = f.read()
        # Some user inputs had extra text before or after the JSON array
        start = content.find('[')
        end = content.rfind(']')
        return json.loads(content[start:end+1])

p1 = load_part(parts[0])
p2 = load_part(parts[1])
p3 = load_part(parts[2])
p4 = load_part(parts[3])
p5 = load_part(parts[4])
p6 = load_part(parts[5])

# preguntas.json has a "preguntas" wrapper for the first 100
with open('assets/data/preguntas.json', 'w', encoding='utf-8') as f:
    json.dump({"preguntas": p1 + p2}, f, ensure_ascii=False, indent=2)

# new_preguntas.json has 101-200
with open('assets/data/new_preguntas.json', 'w', encoding='utf-8') as f:
    json.dump(p3 + p4, f, ensure_ascii=False, indent=2)

# new_preguntas2.json has 201-300
with open('assets/data/new_preguntas2.json', 'w', encoding='utf-8') as f:
    json.dump(p5 + p6, f, ensure_ascii=False, indent=2)
