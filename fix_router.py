with open('C:/Users/PC/Downloads/EDUPOL-flutter/lib/core/config/app_router.dart', 'r', encoding='utf-8') as f:
    code = f.read()

route_str = '''
        GoRoute(
          path: '/psicolearn/razonamiento',
          builder: (context, state) => const SilogismosScreen(),
        ),'''

if "path: '/psicolearn/razonamiento'" not in code:
    code = code.replace("builder: (context, state) => const ReEntrenamientoScreen(),\n          ),", "builder: (context, state) => const ReEntrenamientoScreen(),\n          )," + route_str)

with open('C:/Users/PC/Downloads/EDUPOL-flutter/lib/core/config/app_router.dart', 'w', encoding='utf-8') as f:
    f.write(code)
print('Updated app_router.dart successfully.')
