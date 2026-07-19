with open('C:/Users/PC/Downloads/EDUPOL-flutter/lib/features/interview/presentation/interview_screen.dart', 'r', encoding='utf-8') as f:
    code = f.read()

code = code.replace("import 'package:learn/core/theme/app_theme.dart';", "import 'package:learn/core/config/neural_theme.dart';")
code = code.replace("import 'package:learn/core/widgets/laboratory_background.dart';", "")
code = code.replace("AppTheme.accentColor", "NeuralTheme.accentColor")
code = code.replace("LaboratoryBackground()", "Container(color: NeuralTheme.backgroundColor)")

with open('C:/Users/PC/Downloads/EDUPOL-flutter/lib/features/interview/presentation/interview_screen.dart', 'w', encoding='utf-8') as f:
    f.write(code)

print('Fixed AppTheme and Background')
