with open('C:/Users/PC/Downloads/EstudiEO-flutter/lib/core/config/app_router.dart', 'r', encoding='utf-8') as f:
    code = f.read()

import_str = "import 'package:learn/features/psicolearn/presentation/silogismos_screen.dart';"
if import_str not in code:
    code = code.replace("import 'package:learn/features/psicolearn/presentation/re_entrenamiento_screen.dart';", "import 'package:learn/features/psicolearn/presentation/re_entrenamiento_screen.dart';\n" + import_str)

route_str = '''
        GoRoute(
          path: 'razonamiento',
          builder: (context, state) => const SilogismosScreen(),
        ),'''
if "path: 'razonamiento'" not in code:
    code = code.replace("path: 're-entrenamiento',\n          builder: (context, state) => const ReEntrenamientoScreen(),\n        ),", "path: 're-entrenamiento',\n          builder: (context, state) => const ReEntrenamientoScreen(),\n        )," + route_str)

with open('C:/Users/PC/Downloads/EstudiEO-flutter/lib/core/config/app_router.dart', 'w', encoding='utf-8') as f:
    f.write(code)

print('Updated app_router.dart')
