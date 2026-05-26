import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get_storage/get_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:learn/firebase_options.dart';

import 'package:learn/services/local_storage_service.dart';
import 'package:learn/services/auth_service.dart';
import 'package:learn/providers/srs_provider.dart';
import 'package:learn/providers/gamification_provider.dart';
import 'package:learn/providers/quiz_provider.dart';
import 'package:learn/providers/subject_provider.dart';
import 'package:learn/providers/learning_provider.dart';
import 'package:learn/models/learning_level.dart';

import 'package:learn/screens/home_screen.dart';
import 'package:learn/screens/login_screen.dart';
import 'package:learn/screens/subject_gallery_screen.dart';
import 'package:learn/screens/topic_gallery_screen.dart';
import 'package:learn/screens/exam_screen.dart';
import 'package:learn/screens/exam_results_screen.dart';
import 'package:learn/screens/quiz_screen.dart';
import 'package:learn/screens/quiz_results_screen.dart';
import 'package:learn/screens/dashboard_screen.dart';
import 'package:learn/screens/srs_review_screen.dart';
import 'package:learn/screens/srs_mini_quiz_screen.dart';
import 'package:learn/screens/settings_screen.dart';
import 'package:learn/screens/premium_screen.dart';
import 'package:learn/screens/payment_screen.dart';
import 'package:learn/screens/learning_theory_screen.dart';
import 'package:learn/screens/learning_quiz_screen.dart';
import 'package:learn/screens/learning_levelup_screen.dart';
import 'package:learn/widgets/professional_splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await GetStorage.init();
  final storageService = LocalStorageService();
  await storageService.init();

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
        ChangeNotifierProvider(create: (_) => SubjectProvider(storageService)),
        ChangeNotifierProvider(create: (_) => LearningProvider(storageService)),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'estudiEO',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF3B82F6),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
        fontFamily: 'Inter',
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          },
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const AuthWrapper(),
      routes: {
        '/home': (context) => const HomeScreen(),
        '/gallery': (context) => const SubjectGalleryScreen(),
        '/topics': (context) {
          final subjectId = ModalRoute.of(context)!.settings.arguments as String;
          return TopicGalleryScreen(subjectId: subjectId);
        },
        '/quiz': (context) => const QuizScreen(),
        '/quiz-results': (context) => const QuizResultsScreen(),
        '/exam': (context) => const ExamScreen(),
        '/exam-results': (context) => const ExamResultsScreen(),
        '/dashboard': (context) => const DashboardScreen(),
        '/srs-review': (context) => const SrsReviewScreen(),
        '/srs-mini-quiz': (context) {
          final questionIds = ModalRoute.of(context)!.settings.arguments as List<String>;
          return SrsMiniQuizScreen(questionIds: questionIds);
        },
        '/settings': (context) => const SettingsScreen(),
        '/premium': (context) => const PremiumScreen(),
        '/payment': (context) => const PaymentScreen(),
        '/learning-theory': (context) {
          final args =
              ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
          return LearningTheoryScreen(
            topicId: args['topicId'] as String,
            nivel: args['nivel'] as Dificultad,
          );
        },
        '/learning-quiz': (context) {
          final args =
              ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
          return LearningQuizScreen(
            topicId: args['topicId'] as String,
            nivel: args['nivel'] as Dificultad,
          );
        },
        '/learning-levelup': (context) {
          final args =
              ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
          return LearningLevelUpScreen(
            topicId: args['topicId'] as String,
            nivel: args['nivel'] as Dificultad,
            elapsed: args['elapsed'] as Duration? ?? Duration.zero,
          );
        },
      },
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = context.watch<AuthService>();
    
    if (authService.isInitializing) {
      return const ProfessionalSplash();
    }
    
    if (authService.currentUser != null && authService.isAuthorized) {
      return const HomeScreen();
    }
    
    // Logged in but not authorized → show payment screen
    if (authService.currentUser != null && !authService.isAuthorized) {
      return const PaymentScreen();
    }
    
    return const LoginScreen();
  }
}
