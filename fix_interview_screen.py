import re

with open('C:/Users/PC/Downloads/EstudiEO-flutter/lib/features/interview/presentation/interview_screen.dart', 'r', encoding='utf-8') as f:
    code = f.read()

# Fix imports
code = code.replace("import 'package:learn/core/di/service_locator.dart';", "import 'package:provider/provider.dart';")
code = code.replace("import 'package:learn/core/services/storage_service.dart';", "import 'package:learn/core/services/local_storage_service.dart';")

# Fix declarations
code = code.replace("final InterviewService _service = sl<InterviewService>();", "late final InterviewService _service;")
code = code.replace("final StorageService _storage = sl<StorageService>();\n  ", "")

# Fix initState
init_state_old = '''  void initState() {
    super.initState();
    _isRealismMode = _storage.getBool('interview_realism_mode') ?? false;
    _loadQuestions();
  }'''

init_state_new = '''  void initState() {
    super.initState();
    final storage = context.read<LocalStorageService>();
    _service = InterviewService(storage);
    _isRealismMode = storage.getInterviewRealismMode();
    _loadQuestions();
  }'''

code = code.replace(init_state_old, init_state_new)

with open('C:/Users/PC/Downloads/EstudiEO-flutter/lib/features/interview/presentation/interview_screen.dart', 'w', encoding='utf-8') as f:
    f.write(code)

print('Updated interview_screen.dart')
