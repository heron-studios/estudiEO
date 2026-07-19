import os

source_file = r"c:\Users\PC\Downloads\EDUPOL-flutter\lib\data\library\comunicacion\comunicacion_questions.dart"

with open(source_file, 'r', encoding='utf-8', errors='ignore') as f:
    lines = f.readlines()

def clean_lines(lines_list):
    cleaned = []
    in_text_field = False
    
    for i, line in enumerate(lines_list):
        stripped = line.strip()
        
        if stripped.startswith("text:"):
            in_text_field = True
            cleaned.append(line)
            continue
            
        if in_text_field:
            if stripped:
                quote_char = None
                if stripped.startswith('"'):
                    quote_char = '"'
                elif stripped.startswith("'"):
                    quote_char = "'"
                    
                if quote_char:
                    start_pos = line.find(quote_char)
                    idx = start_pos + 1
                    
                    while idx < len(line):
                        if line[idx] == '\\':
                            idx += 2
                            continue
                        if line[idx] == quote_char:
                            closing_pos = idx
                            break
                        idx += 1
                    else:
                        closing_pos = -1
                        
                    if closing_pos != -1:
                        string_literal = line[:closing_pos + 1]
                        remainder = line[closing_pos + 1:].strip()
                        
                        if remainder and remainder != ",":
                            new_line = string_literal + ",\n"
                            cleaned.append(new_line)
                        else:
                            cleaned.append(line)
                    else:
                        cleaned.append(line)
                else:
                    cleaned.append(line)
                in_text_field = False
            else:
                cleaned.append(line)
        else:
            cleaned.append(line)
            
    return cleaned

cleaned_lines = clean_lines(lines)

with open(source_file, 'w', encoding='utf-8') as f:
    f.writelines(cleaned_lines)

print("Clean applied successfully to comunicacion_questions.dart.")
