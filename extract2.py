import json

log_path = 'C:/Users/PC/.gemini/antigravity/brain/337c2c35-a6f5-46f2-a8cd-d5aba91524f5/.system_generated/logs/transcript.jsonl'
blocks = {}
with open(log_path, 'r', encoding='utf-8') as f:
    for line in f:
        data = json.loads(line)
        if data.get('type') == 'USER_INPUT':
            content = data.get('content', '')
            if '"id": 1,' in content: blocks[1] = content
            if '"id": 51,' in content: blocks[51] = content
            if '"id": 101,' in content: blocks[101] = content
            if '"id": 151,' in content: blocks[151] = content
            if '"id": 201,' in content: blocks[201] = content
            if '"id": 251,' in content: blocks[251] = content

print(f'Found blocks: {list(blocks.keys())}')
for k, v in blocks.items():
    print(f'Block {k} length: {len(v)}')
    if '<truncated' in v:
        print(f'Block {k} IS TRUNCATED!')
