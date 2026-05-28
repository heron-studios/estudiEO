import os
import sys

def create_files_from_prompt(prompt_file_path, base_topic_id, prefix, subject_folder):
    with open(prompt_file_path, 'r', encoding='utf-8') as f:
        content = f.read()

    # Split by levels
    levels_raw = content.split('====== NIVEL ')
    levels = []
    for level_str in levels_raw:
        if not level_str.strip() or ' ======' not in level_str:
            continue
        level_name = level_str.split(' ======')[0].strip()
        rest = level_str.split(' ======')[1]
        levels.append({'name': level_name, 'content': rest})

    theory_dict = {}
    questions_list = []

    for level in levels:
        name = level['name'].lower()
        if name == 'fácil':
            level_key = 'easy'
        elif name == 'medio':
            level_key = 'medium'
        elif name == 'difícil':
            level_key = 'hard'
        elif name == 'extremo':
            level_key = 'extreme'
        else:
            level_key = name

        content = level['content']
        # Split into theory and questions
        if '--- PREGUNTAS ---' in content:
            theory_part = content.split('--- PREGUNTAS ---')[0]
            questions_part = content.split('--- PREGUNTAS ---')[1]
        else:
            theory_part = content
            questions_part = ""

        if '--- TEORÍA ---' in theory_part:
            theory_text = theory_part.split('--- TEORÍA ---')[1].strip()
        else:
            theory_text = theory_part.strip()
        
        theory_dict[level_key] = theory_text

        # Parse questions
        q_blocks = questions_part.split('Pregunta ')
        for block in q_blocks:
            if not block.strip():
                continue
            
            lines = block.strip().split('\n')
            first_line = lines[0]
            q_num_str = first_line.split(':')[0]
            q_num = int(q_num_str)
            q_text = ':'.join(first_line.split(':')[1:]).strip()

            options = []
            correct_letter = None
            explanation = ""
            
            for line in lines[1:]:
                line = line.strip()
                if not line:
                    continue
                if line.startswith('A) ') or line.startswith('B) ') or line.startswith('C) ') or line.startswith('D) ') or line.startswith('E) '):
                    options.append(line[3:].strip())
                elif line.endswith(') Correcta'):
                    correct_letter = line[0]
                elif line.startswith('EXP:'):
                    explanation = line[4:].strip()
                else:
                    if correct_letter:
                        explanation += " " + line

            if not options:
                continue

            options.append("Correcta")

            questions_list.append({
                'id': f"{prefix}_q{q_num}",
                'topicId': base_topic_id,
                'text': q_text,
                'options': options,
                'correctAnswer': -1,
                'explanation': explanation
            })

    # Generate Theory dart file
    base_name = base_topic_id.replace('eo_pnp_', '')
    camel_case_name = "".join(x.capitalize() for x in base_name.split('_'))
    camel_case_name = camel_case_name[0].lower() + camel_case_name[1:]
    
    theory_dart = ""
    for level, text in theory_dict.items():
        var_name = f"{camel_case_name}Theory{level.capitalize()}"
        theory_dart += f"const String {var_name} = r'''{text}''';\n\n"

    # Generate Questions dart file
    questions_dart = f"import 'package:learn/models/question.dart';\n\nfinal List<Question> {camel_case_name}Questions = [\n"
    for q in questions_list:
        opts_str = ",\n      ".join([f"r'''{opt}'''" for opt in q['options']])
        
        questions_dart += f"""  Question(
    id: "{q['id']}",
    topicId: "{q['topicId']}",
    text: r'''{q['text']}''',
    options: [
      {opts_str}
    ],
    correctAnswer: -1,
    explanation: r'''{q['explanation']}''',
  ),\n"""
    questions_dart += "];\n"

    # Write files
    theory_file = os.path.join(os.path.dirname(prompt_file_path), f"lib/data/library/{subject_folder}/{base_name}_theory.dart")
    questions_file = os.path.join(os.path.dirname(prompt_file_path), f"lib/data/library/{subject_folder}/{base_name}_questions.dart")

    os.makedirs(os.path.dirname(theory_file), exist_ok=True)
    with open(theory_file, 'w', encoding='utf-8') as f:
        f.write(theory_dart)
        
    with open(questions_file, 'w', encoding='utf-8') as f:
        f.write(questions_dart)
        
    print(f"Generated {theory_file} and {questions_file}")

if __name__ == "__main__":
    prompt_file_path = sys.argv[1]
    subject_folder = sys.argv[2]
    
    with open(prompt_file_path, 'r', encoding='utf-8') as f:
        content = f.read()
    
    base_topic_id = ""
    prefix = ""
    for line in content.split('\n'):
        if line.startswith('TOPIC_ID:'):
            base_topic_id = line.split('TOPIC_ID:')[1].strip()
        elif line.startswith('PREFIX:'):
            prefix = line.split('PREFIX:')[1].strip()
            
    create_files_from_prompt(prompt_file_path, base_topic_id, prefix, subject_folder)
