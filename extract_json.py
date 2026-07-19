import json
import re

log_path = 'C:/Users/PC/.gemini/antigravity/brain/337c2c35-a6f5-46f2-a8cd-d5aba91524f5/.system_generated/logs/transcript.jsonl'
msgs = []
with open(log_path, 'r', encoding='utf-8') as f:
    for line in f:
        data = json.loads(line)
        if data.get('type') == 'USER_INPUT':
            msgs.append(data.get('content', ''))

for m in msgs:
    if '"id": 1,' in m and '"texto":' in m:
        with open('C:/Users/PC/Downloads/EDUPOL-flutter/assets/data/preguntas_1_50.json', 'w', encoding='utf-8') as f:
            f.write(m)
    if '"id": 51,' in m and '"texto":' in m:
        with open('C:/Users/PC/Downloads/EDUPOL-flutter/assets/data/preguntas_51_100.json', 'w', encoding='utf-8') as f:
            f.write(m)
    if '"id": 101,' in m and '"texto":' in m:
        with open('C:/Users/PC/Downloads/EDUPOL-flutter/assets/data/preguntas_101_150.json', 'w', encoding='utf-8') as f:
            f.write(m)
    if '"id": 151,' in m and '"texto":' in m:
        with open('C:/Users/PC/Downloads/EDUPOL-flutter/assets/data/preguntas_151_200.json', 'w', encoding='utf-8') as f:
            f.write(m)
    if '"id": 201,' in m and '"texto":' in m:
        with open('C:/Users/PC/Downloads/EDUPOL-flutter/assets/data/preguntas_201_250.json', 'w', encoding='utf-8') as f:
            f.write(m)
    if '"id": 251,' in m and '"texto":' in m:
        with open('C:/Users/PC/Downloads/EDUPOL-flutter/assets/data/preguntas_251_300.json', 'w', encoding='utf-8') as f:
            f.write(m)
