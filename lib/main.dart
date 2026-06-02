import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:learn/config/neural_theme.dart';
import 'package:learn/config/app_router.dart';
import 'package:learn/firebase_options.dart';
import 'package:learn/services/local_storage_service.dart';
import 'package:learn/services/auth_service.dart';
import 'package:learn/providers/srs_provider.dart';
import 'package:learn/providers/gamification_provider.dart';
import 'package:learn/providers/quiz_provider.dart';
import 'package:learn/providers/subject_provider.dart';
import 'package:learn/providers/learning_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // usePathUrlStrategy(); // Desactivado para evitar errores 404 en GitHub Pages

  // Initialize Hive first (essential for offline storage)
  try {
    await Hive.initFlutter();
    await Hive.openBox('estudieo_data');
  } catch (e) {
    debugPrint('Hive init error: $e');
  }

  // Initialize Firebase (essential for Auth/Firestore)
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    debugPrint('Firebase init error: $e');
  }

  final storageService = LocalStorageService();
  try {
    await storageService.init();
  } catch (e) {
    debugPrint('LocalStorageService init error: $e');
  }

  runApp(
    MultiProvider(
      providers: [
        Provider<LocalStorageService>.value(value: storageService),
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (_) => SrsProvider(storageService)),
        ChangeNotifierProvider(
          create: (_) => GamificationProvider(storageService),
        ),
        ChangeNotifierProvider(create: (_) => QuizProvider(storageService)),
        ChangeNotifierProxyProvider<AuthService, SubjectProvider>(
          create: (_) => SubjectProvider(storageService),
          update: (_, auth, subject) => subject!..setPremium(auth.isAuthorized),
        ),
        ChangeNotifierProxyProvider<GamificationProvider, LearningProvider>(
          create: (_) => LearningProvider(storageService),
          update: (_, gamification, learning) => learning!..updateGamification(gamification),
        ),
      ],
      child: const MyApp(),
    ),
  );
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
    _router = AppRouter.createRouter(context.read<AuthService>());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'estudiEO',
      theme: NeuralTheme.buildThemeData(),
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
    );
  }
}
