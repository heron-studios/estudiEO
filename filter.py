import json
import statistics

input_file = r'C:\Users\PC\Downloads\EstudiEO-flutter\assets\data\silogismos.json'

with open(input_file, 'r', encoding='utf-8') as f:
    data = json.load(f)

lengths = [len(item['texto']) for item in data]
print(f'Total items: {len(data)}')
print(f'Average length: {sum(lengths)/len(lengths):.2f}')
print(f'Max length: {max(lengths)}')
print(f'Min length: {min(lengths)}')
print(f'Median length: {statistics.median(lengths)}')

# let's look at the top 15 longest ones
sorted_items = sorted(data, key=lambda x: len(x['texto']), reverse=True)
for i in range(20):
    item = sorted_items[i]
    print(f"[{item['id']}] Len: {len(item['texto'])} - {item['texto'][:50]}...")
