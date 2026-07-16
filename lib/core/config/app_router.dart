import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:learn/features/auth/domain/auth_service.dart';
import 'package:learn/models/learning_level.dart';
import 'package:learn/models/question.dart';
import 'package:learn/features/interview/presentation/interview_screen.dart';
import 'package:learn/features/interview/presentation/interview_trivia_screen.dart';
import 'package:learn/screens/entrevista_simulator/entrevista_simulator_screen.dart';

// Screens
import 'package:learn/features/home/presentation/app_shell.dart';
import 'package:learn/features/home/presentation/home_screen.dart';
import 'package:learn/features/auth/presentation/login_screen.dart';
import 'package:learn/features/onboarding/presentation/onboarding_screen.dart';
import 'package:learn/core/services/local_storage_service.dart';
import 'package:learn/features/learning/presentation/subject_gallery_screen.dart';
import 'package:learn/features/learning/presentation/topic_gallery_screen.dart';
import 'package:learn/features/exam/presentation/exam_screen.dart';
import 'package:learn/features/exam/presentation/exam_results_screen.dart';
import 'package:learn/features/exam/presentation/exam_review_screen.dart';
import 'package:learn/features/quiz/presentation/quiz_screen.dart';
import 'package:learn/features/quiz/presentation/quiz_results_screen.dart';
import 'package:learn/features/srs/presentation/srs_review_screen.dart';
import 'package:learn/features/srs/presentation/srs_mini_quiz_screen.dart';
import 'package:learn/features/settings/presentation/settings_screen.dart';
import 'package:learn/features/premium/presentation/payment_screen.dart';
import 'package:learn/features/learning/presentation/learning_theory_screen.dart';
import 'package:learn/features/learning/presentation/learning_quiz_screen.dart';
import 'package:learn/features/learning/presentation/learning_levelup_screen.dart';
import 'package:learn/features/miniapps/presentation/miniapps_screen.dart';
import 'package:learn/features/miniapps/periodic_table_screen.dart';
import 'package:learn/features/miniapps/anp_master/presentation/anp_master_screen.dart';
import 'package:learn/features/miniapps/anp_master/presentation/anp_map_view.dart';
import 'package:learn/features/miniapps/anp_master/presentation/anp_flashcards_view.dart';
import 'package:learn/features/miniapps/anp_master/presentation/anp_quiz_view.dart';
import 'package:learn/features/miniapps/anp_master/presentation/anp_library_view.dart';
import 'package:learn/features/psicolearn/presentation/psicolearn_screen.dart';
import 'package:learn/features/psicolearn/presentation/simulator_screen.dart';
import 'package:learn/features/psicolearn/presentation/re_entrenamiento_screen.dart';
import 'package:learn/features/psicolearn/presentation/silogismos_screen.dart';
import 'package:learn/features/miniapps/productos_notables/presentation/productos_notables_screen.dart';
import 'package:learn/features/medical/presentation/medical_dashboard_screen.dart';
import 'package:learn/features/medical/presentation/eysenck_test_screen.dart';
import 'package:learn/features/medical/presentation/sacks_test_screen.dart';
import 'package:learn/features/medical/presentation/psicologico_test_screen.dart';
import 'package:learn/features/medical/presentation/trail_making_test_screen.dart';
import 'package:learn/features/flashcards/presentation/flashcards_selector_screen.dart';
import 'package:learn/features/psicolearn/presentation/psico_mission_screen.dart';
import 'package:learn/features/fitness/presentation/fitness_calculator_screen.dart';
import 'package:learn/features/merit/presentation/merit_calculator_screen.dart';
import 'package:learn/features/roadmap/presentation/roadmap_screen.dart';

class AppRouter {
  static GoRouter createRouter(
    AuthService authService,
    LocalStorageService storageService,
  ) {
    return GoRouter(
      initialLocation: '/home',
      refreshListenable: authService,
      redirect: (context, state) {
        final isAuth = authService.currentUser != null;
        final isAuthorized = authService.isAuthorized;
        final isInitializing = authService.isInitializing;
        final hasSeenOnboarding = storageService.loadHasSeenOnboarding();

        final isLoggingIn = state.matchedLocation == '/login';
        final isPayment = state.matchedLocation == '/payment';
        final isLoading = state.matchedLocation == '/loading';
        final isOnboarding = state.matchedLocation == '/onboarding';

        if (isInitializing) {
          return isLoading ? null : '/loading';
        }

        if (!hasSeenOnboarding) {
          return isOnboarding ? null : '/onboarding';
        }

        if (!isAuth) {
          return isLoggingIn ? null : '/login';
        }

        if (isAuth && isAuthorized) {
          if (isLoggingIn || isPayment || isLoading || isOnboarding) {
            return '/home';
          }
        } else {
          if (isLoggingIn || isLoading || isOnboarding) {
            return '/home';
          }
        }

        return null;
      },
      routes: [
        GoRoute(
          path: '/loading',
          builder: (context, state) => const Scaffold(
            backgroundColor: Color(0xFF0F172A),
            body: Center(
              child: CircularProgressIndicator(color: Color(0xFF3B82F6)),
            ),
          ),
        ),
        GoRoute(
          path: '/onboarding',
          builder: (context, state) => const OnboardingScreen(),
        ),
        GoRoute(
          path: '/login',
          builder: (context, state) => const LoginScreen(),
        ),
        StatefulShellRoute.indexedStack(
          builder: (context, state, navigationShell) {
            return AppShell(navigationShell: navigationShell);
          },
          branches: [
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: '/home',
                  builder: (context, state) => const HomeScreen(),
                ),
              ],
            ),

            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: '/miniapps',
                  builder: (context, state) => const MiniAppsScreen(),
                ),
              ],
            ),
          ],
        ),
        GoRoute(
          path: '/gallery',
          builder: (context, state) {
            final extra = state.extra;
            final mode = (extra is Map && extra.containsKey('mode'))
                ? extra['mode'] as String
                : 'quiz';
            return SubjectGalleryScreen(mode: mode);
          },
        ),
        GoRoute(
          path: '/topics',
          builder: (context, state) {
            final extra = state.extra;
            if (extra is Map) {
              return TopicGalleryScreen(
                subjectId: extra['subjectId'] as String,
                mode: extra['mode'] as String? ?? 'quiz',
              );
            }
            return TopicGalleryScreen(subjectId: extra as String);
          },
        ),
        GoRoute(path: '/quiz', builder: (context, state) => const QuizScreen()),
        GoRoute(
          path: '/quiz-results',
          builder: (context, state) => const QuizResultsScreen(),
        ),
        GoRoute(
          path: '/exam',
          builder: (context, state) {
            final extra = state.extra as Map<String, dynamic>?;
            final resume = extra?['resume'] as bool? ?? false;
            return ExamScreen(resume: resume);
          },
        ),
        GoRoute(
          path: '/exam-results',
          builder: (context, state) {
            final extra = state.extra as Map<String, dynamic>? ?? {};
            return ExamResultsScreen(args: extra);
          },
        ),
        GoRoute(
          path: '/exam-review',
          builder: (context, state) {
            final extra = state.extra as Map<String, dynamic>;
            return ExamReviewScreen(
              questions: extra['questions'] as List<Question>,
              answers: Map<String, int>.from(extra['answers'] as Map),
            );
          },
        ),
        GoRoute(
          path: '/srs-review',
          builder: (context, state) => const SrsReviewScreen(),
        ),
        GoRoute(
          path: '/srs-mini-quiz',
          builder: (context, state) {
            final questionIds = state.extra as List<String>;
            return SrsMiniQuizScreen(questionIds: questionIds);
          },
        ),
        GoRoute(
          path: '/premium',
          builder: (context, state) => const PaymentScreen(),
        ),
        GoRoute(
          path: '/payment',
          builder: (context, state) => const PaymentScreen(),
        ),
        GoRoute(
          path: '/learning-theory',
          builder: (context, state) {
            final extra = state.extra as Map;
            return LearningTheoryScreen(
              topicId: extra['topicId'] as String,
              nivel: extra['nivel'] as Dificultad,
            );
          },
        ),
        GoRoute(
          path: '/learning-quiz',
          builder: (context, state) {
            final extra = state.extra as Map;
            return LearningQuizScreen(
              topicId: extra['topicId'] as String,
              nivel: extra['nivel'] as Dificultad,
            );
          },
        ),
        GoRoute(
          path: '/learning-levelup',
          builder: (context, state) {
            final extra = state.extra as Map;
            return LearningLevelUpScreen(
              topicId: extra['topicId'] as String,
              nivel: extra['nivel'] as Dificultad,
              elapsed: extra['elapsed'] as Duration? ?? Duration.zero,
            );
          },
        ),
        GoRoute(
          path: '/settings',
          builder: (context, state) => const SettingsScreen(),
        ),
        GoRoute(
          path: '/miniapps/periodic-table',
          builder: (context, state) => const PeriodicTableScreen(),
        ),
        GoRoute(
          path: '/miniapps/silogismos',
          builder: (context, state) => const SilogismosScreen(),
        ),
        GoRoute(
          path: '/miniapps/anp-master',
          builder: (context, state) => const ANPMasterScreen(),
        ),
        GoRoute(
          path: '/miniapps/anp-master/map',
          builder: (context, state) => const ANPMapView(),
        ),
        GoRoute(
          path: '/miniapps/anp-master/flashcards',
          builder: (context, state) => const ANPFlashcardsView(),
        ),
        GoRoute(
          path: '/miniapps/anp-master/quiz',
          builder: (context, state) => const ANPQuizView(),
        ),
        GoRoute(
          path: '/miniapps/anp-master/library',
          builder: (context, state) => const ANPLibraryView(),
        ),
        GoRoute(
          path: '/miniapps/productos-notables',
          builder: (context, state) => const ProductosNotablesScreen(),
        ),

        GoRoute(
          path: '/medical',
          builder: (context, state) => const MedicalDashboardScreen(),
        ),
        GoRoute(
          path: '/medical/psicologico',
          builder: (context, state) => const PsicologicoTestScreen(),
        ),
        GoRoute(
          path: '/medical/eysenck',
          builder: (context, state) => const EysenckTestScreen(),
        ),
        GoRoute(
          path: '/medical/sacks',
          builder: (context, state) => const SacksTestScreen(),
        ),
        GoRoute(
          path: '/medical/trail-making',
          builder: (context, state) => const TrailMakingTestScreen(),
        ),
        GoRoute(
          path: '/psicolearn',
          builder: (context, state) => const PsicoLearnScreen(),
        ),

        GoRoute(
          path: '/psicolearn/simulator',
          builder: (context, state) => const SimulatorScreen(),
        ),
        GoRoute(
          path: '/psicolearn/re-entrenamiento',
          builder: (context, state) => const ReEntrenamientoScreen(),
        ),
        GoRoute(
          path: '/psicolearn/razonamiento',
          builder: (context, state) => const SilogismosScreen(),
        ),
        GoRoute(
          path: '/psicolearn/entrevista',
          builder: (context, state) => const InterviewScreen(),
        ),
        GoRoute(
          path: '/interview-trivia',
          builder: (context, state) => const InterviewTriviaScreen(),
        ),
        GoRoute(
          path: '/entrevista-simulator',
          builder: (context, state) => const EntrevistaSimulatorScreen(),
        ),
        GoRoute(
          path: '/flashcards',
          builder: (context, state) => const FlashcardsSelectorScreen(),
        ),
        GoRoute(
          path: '/psico-mission',
          builder: (context, state) => const PsicoMissionScreen(),
        ),
        GoRoute(
          path: '/fitness-calculator',
          builder: (context, state) => const FitnessCalculatorScreen(),
        ),
        GoRoute(
          path: '/merit-calculator',
          builder: (context, state) => const MeritCalculatorScreen(),
        ),
        GoRoute(
          path: '/roadmap',
          builder: (context, state) => const RoadmapScreen(),
        ),
      ],
    );
  }
}
