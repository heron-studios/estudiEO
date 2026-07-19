import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:learn/core/config/neural_theme.dart';
import 'package:learn/core/config/app_router.dart';
import 'package:learn/firebase_options.dart';
import 'package:learn/core/services/local_storage_service.dart';
import 'package:learn/features/auth/domain/auth_service.dart';
import 'package:learn/core/services/audio_service.dart';
import 'package:learn/providers/srs_provider.dart';
import 'package:learn/providers/gamification_provider.dart';
import 'package:learn/providers/quiz_provider.dart';
import 'package:learn/providers/subject_provider.dart';
import 'package:learn/providers/learning_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    // Initialize Hive first (essential for offline storage)
    await Hive.initFlutter();
    await Hive.openBox('EDUPOL_data');

    // Initialize Firebase (essential for Auth/Firestore)
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    final storageService = LocalStorageService();
    await storageService.init();

    runApp(
      MultiProvider(
        providers: [
          Provider<LocalStorageService>.value(value: storageService),
          ChangeNotifierProvider<AudioService>(
            create: (_) => AudioService(storageService),
          ),
          ChangeNotifierProvider(create: (_) => AuthService()),
          ChangeNotifierProvider(create: (_) => SrsProvider(storageService)),
          ChangeNotifierProvider(
            create: (_) => GamificationProvider(storageService),
          ),
          ChangeNotifierProvider(create: (_) => QuizProvider(storageService)),
          ChangeNotifierProxyProvider<AuthService, SubjectProvider>(
            create: (_) => SubjectProvider(storageService),
            update: (_, auth, subject) =>
                subject!..setPremium(auth.isAuthorized),
          ),
          ChangeNotifierProxyProvider<GamificationProvider, LearningProvider>(
            create: (_) => LearningProvider(storageService),
            update: (_, gamification, learning) =>
                learning!..updateGamification(gamification),
          ),
        ],
        child: const MyApp(),
      ),
    );
  } catch (e, stacktrace) {
    debugPrint('Initialization error: $e\n$stacktrace');
    runApp(FallbackApp(error: e.toString()));
  }
}

class FallbackApp extends StatelessWidget {
  final String error;
  const FallbackApp({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color(0xFF0F172A),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.error_outline,
                  color: Colors.redAccent,
                  size: 60,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Error de Inicialización',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Ocurrió un problema crítico. Reinicia la aplicación.\n\nDetalles:\n$error',
                  style: const TextStyle(color: Colors.white70, fontSize: 14),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();
    _router = AppRouter.createRouter(
      context.read<AuthService>(),
      context.read<LocalStorageService>(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'EDUPOL',
      theme: NeuralTheme.buildThemeData(),
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
    );
  }
}
