import json

log_path = r"C:\Users\PC\.gemini\antigravity\brain\380ed37e-fb3f-4092-80b1-ae54cde8063e\.system_generated\logs\transcript.jsonl"
out_path = r"C:\Users\PC\Downloads\EDUPOL-flutter\extracted_topic.txt"

with open(log_path, 'r', encoding='utf-8') as f_in:
    for line in f_in:
        try:
            data = json.loads(line)
            if data.get('step_index') == 972 or (data.get('type') == 'USER_INPUT' and 'pfrh_funciones_violencia_familiar' in data.get('content', '')):
                with open(out_path, 'w', encoding='utf-8') as f_out:
                    f_out.write(data['content'])
                print("Successfully extracted step 972 to extracted_topic.txt")
                break
        except Exception as e:
            continue
