import re

file_path = r'c:\Users\PC\Downloads\EstudiEO-flutter\lib\features\medical\presentation\eysenck_test_screen.dart'
with open(file_path, 'r', encoding='utf-8') as f:
    content = f.read()

# Add EysenckQuestion class
class_def = '''
class EysenckQuestion {
  final String text;
  final bool expectedAnswer;
  final String explanation;
  EysenckQuestion(this.text, this.expectedAnswer, this.explanation);
}
'''
if 'class EysenckQuestion' not in content:
    content = content.replace('class EysenckTestScreen extends StatefulWidget', class_def + '\nclass EysenckTestScreen extends StatefulWidget')

# Transform _questions
old_q_pattern = r'final List<String> _questions = \[(.*?)\];'
match = re.search(old_q_pattern, content, re.DOTALL)
if match:
    old_qs = match.group(1)
    new_qs_lines = []
    lines = old_qs.split('\n')
    for line in lines:
        if line.strip() == '': continue
        if line.strip().startswith('//'): continue
        text_match = re.search(r'\'(.*?)\'', line)
        if not text_match: continue
        q = text_match.group(1)
        # determine expected and explanation
        expected = 'true'
        expl = 'Bien: Rasgo positivo para el perfil institucional.'
        
        negatives = ['bullicio', 'intranquilidad', 'triste', 'retraído', 'enfada', 'melancólico', 'sueño', 'malhumorado', 'despreocupado', 'tarde', 'apático', 'groseros', 'hastiado', 'distrae', 'abstrae', 'pasado', 'susceptible', 'inquieto', 'mareos', 'aire', 'nervios', 'mañana', 'nervioso', 'cabeza', 'mentiras', 'primero', 'embarazosa', 'hermético', 'problemas', 'perder', 'consciente', 'sensaciones']
        for n in negatives:
            if n in q.lower():
                expected = 'false'
                expl = 'Mal: Indica inestabilidad emocional, impulsividad o bajo control de impulsos.'
                break
        
        if expected == 'true':
            expl = 'Bien: Indica estabilidad emocional, disciplina o nivel adecuado de sociabilidad.'
            
        new_qs_lines.append(f"    EysenckQuestion('{q}', {expected}, '{expl}'),")
    
    new_qs_str = 'final List<EysenckQuestion> _questions = [\n' + '\n'.join(new_qs_lines) + '\n  ];'
    content = content.replace(match.group(0), new_qs_str)

# Update UI usage
content = content.replace('_questions[_currentIndex],', '_questions[_currentIndex].text,')

# Update _answerQuestion logic
old_answer_logic = '''  void _answerQuestion(bool isYes) {
    setState(() {
      _answers[_currentIndex] = isYes;
      if (_currentIndex < _questions.length - 1) {
        _currentIndex++;
      } else {
        // Finished
        _timer?.cancel();
        _showFinishDialog();
      }
    });
  }'''

new_answer_logic = '''  void _answerQuestion(bool isYes) {
    bool isCorrect = _questions[_currentIndex].expectedAnswer == isYes;
    _timer?.cancel(); // Pausa el timer

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        final nt = NeuralTheme.of(context);
        return AlertDialog(
          backgroundColor: const Color(0xFF1E1F20),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide(color: isCorrect ? nt.successGreen : nt.pink, width: 2)),
          title: Row(
            children: [
              Icon(isCorrect ? Icons.check_circle_outline : Icons.cancel_outlined,
                  color: isCorrect ? nt.successGreen : nt.pink, size: 28),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  isCorrect ? '¡Respuesta Ideal!' : 'Cuidado con esta respuesta',
                  style: TextStyle(color: isCorrect ? nt.successGreen : nt.pink, fontSize: 18),
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Respondiste: ${isYes ? "SÍ" : "NO"}',
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 12),
              Text(
                _questions[_currentIndex].explanation,
                style: const TextStyle(color: Colors.white70, fontSize: 15, height: 1.4),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  _answers[_currentIndex] = isYes;
                  if (_currentIndex < _questions.length - 1) {
                    _currentIndex++;
                    _startTimer();
                  } else {
                    _showFinishDialog();
                  }
                });
              },
              child: const Text('Entendido -> Continuar',
                  style: TextStyle(color: Colors.cyan, fontSize: 16)),
            ),
          ],
        );
      },
    );
  }'''

content = content.replace(old_answer_logic, new_answer_logic)

with open(file_path, 'w', encoding='utf-8') as f:
    f.write(content)
print('Success!')
