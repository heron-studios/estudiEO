import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:learn/core/config/neural_theme.dart';
import 'package:learn/core/widgets/neural_background_wrapper.dart';
import 'package:learn/core/services/local_storage_service.dart';
import 'package:lottie/lottie.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> _slides = [
    {
      'title': 'Bienvenido a EDUPOL',
      'body': 'Tu academia digital definitiva para ingresar a las Escuelas de Oficiales y Suboficiales de la PNP. Todo el temario en tu bolsillo.',
      'icon': '👮',
    },
    {
      'title': 'Repaso Espaciado (SRS)',
      'body': 'Nuestro algoritmo inteligente calculará exactamente cuándo debes repasar cada tarjeta para que nunca la olvides.',
      'icon': '🧠',
    },
    {
      'title': 'Tutor IA a tu servicio',
      'body': 'Tu tutor de IA personal que analiza tu progreso y te da consejos de estudio basados en tus estadísticas.',
      'icon': '🤖',
    }
  ];

  void _finishOnboarding() {
    context.read<LocalStorageService>().saveHasSeenOnboarding(true);
    context.go('/home');
  }

  @override
  Widget build(BuildContext context) {
    final nt = NeuralTheme.of(context);

    return Scaffold(
      backgroundColor: nt.background,
      body: NeuralBackgroundWrapper(
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  itemCount: _slides.length,
                  itemBuilder: (context, index) {
                    final slide = _slides[index];
                    return Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (index == 0)
                            SizedBox(
                              height: 180,
                              child: Lottie.asset(
                                'assets/Book loading.lottie',
                                fit: BoxFit.contain,
                              ),
                            )
                          else if (index == 2)
                            SizedBox(
                              height: 180,
                              child: Lottie.asset(
                                'assets/Sparkles Loop Loader ai.lottie',
                                fit: BoxFit.contain,
                              ),
                            )
                          else
                            Text(
                              slide['icon']!,
                              style: const TextStyle(fontSize: 100),
                            ),
                          const SizedBox(height: 40),
                          Text(
                            slide['title']!,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: nt.textPrimary,
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Outfit',
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            slide['body']!,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: nt.textSecondary,
                              fontSize: 16,
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: List.generate(
                        _slides.length,
                        (index) => AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.only(right: 8),
                          height: 8,
                          width: _currentPage == index ? 24 : 8,
                          decoration: BoxDecoration(
                            color: _currentPage == index ? nt.blueGoogle : nt.surfaceCard,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_currentPage == _slides.length - 1) {
                          _finishOnboarding();
                        } else {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: nt.blueGoogle,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        _currentPage == _slides.length - 1 ? 'Empezar' : 'Siguiente',
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
