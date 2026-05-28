import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:learn/services/auth_service.dart';
import 'package:learn/widgets/neural_background_wrapper.dart';
import 'package:learn/config/neural_design_system.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {
  bool _isCheckingAuth = false;
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    )..repeat(reverse: true);
    
    _pulseAnimation = Tween<double>(begin: 0.98, end: 1.02).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  void _handleGoogleSignIn() async {
    final authService = context.read<AuthService>();
    final userCred = await authService.signInWithGoogle();

    if (userCred != null) {
      setState(() => _isCheckingAuth = true);
      await authService.checkAndSetAuthorization();
      if (mounted) {
        setState(() => _isCheckingAuth = false);
      }
    } else {
      if (authService.error != null && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(authService.error!),
            backgroundColor: NeuralDesignSystem.pink,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authService = context.watch<AuthService>();

    return Scaffold(
      backgroundColor: NeuralDesignSystem.background,
      body: NeuralBackgroundWrapper(
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 48.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Sparkle interactivo estilo Gemini
                  ScaleTransition(
                    scale: _pulseAnimation,
                    child: Container(
                      width: 130,
                      height: 130,
                      decoration: BoxDecoration(
                        color: NeuralDesignSystem.surfaceCard.withOpacity(0.5),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: NeuralDesignSystem.blueGoogle.withOpacity(0.25),
                            blurRadius: 40,
                            spreadRadius: 8,
                            offset: const Offset(-8, -8),
                          ),
                          BoxShadow(
                            color: NeuralDesignSystem.purple.withOpacity(0.25),
                            blurRadius: 40,
                            spreadRadius: 8,
                            offset: const Offset(8, 8),
                          ),
                        ],
                        border: Border.all(
                          color: Colors.white.withOpacity(0.15),
                          width: 1.5,
                        ),
                      ),
                      child: ClipOval(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: Center(
                            child: ShaderMask(
                              shaderCallback: (bounds) => NeuralDesignSystem.neuralGradient.createShader(
                                Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                              ),
                              child: const Icon(
                                Icons.auto_awesome,
                                size: 68,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 48),

                  // TÃ­tulo Principal con estilo Neural (Mesh Gradient en Texto)
                  ShaderMask(
                    shaderCallback: (bounds) => NeuralDesignSystem.neuralGradient.createShader(bounds),
                    child: const Text(
                      'estudiEO',
                      style: TextStyle(
                        fontFamily: 'Outfit',
                        fontSize: 56,
                        fontWeight: FontWeight.w900,
                        color: Colors.white, // Requerido para ShaderMask
                        letterSpacing: -1.5,
                        height: 1.1,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  
                  // SubtÃ­tulo persuasivo
                  Text(
                    'Domina el temario PNP con Inteligencia Activa.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: NeuralDesignSystem.textPrimaryAlt.withOpacity(0.9),
                      letterSpacing: -0.3,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'PreparaciÃ³n estratÃ©gica, micro-learning y simulacros diseÃ±ados especÃ­ficamente para asegurar tu ingreso a la Escuela de Oficiales.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 15,
                        color: NeuralDesignSystem.textSecondary,
                        height: 1.5,
                      ),
                    ),
                  ),
                  const SizedBox(height: 56),

                  // Tarjeta Glassmorphism para el Login
                  ClipRRect(
                    borderRadius: BorderRadius.circular(32),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                      child: Container(
                        width: double.infinity,
                        constraints: const BoxConstraints(maxWidth: 380),
                        padding: const EdgeInsets.all(32),
                        decoration: BoxDecoration(
                          color: NeuralDesignSystem.surfaceCard.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(32),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.12),
                            width: 1,
                          ),
                        ),
                        child: Column(
                          children: [
                            const Text(
                              'Inicia tu preparaciÃ³n',
                              style: TextStyle(
                                fontFamily: 'Outfit',
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: NeuralDesignSystem.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 24),

                            // BotÃ³n de Google Moderno
                            if (authService.isLoading || _isCheckingAuth)
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 8.0),
                                child: CircularProgressIndicator(
                                  color: NeuralDesignSystem.blueGoogle,
                                ),
                              )
                            else
                              Container(
                                width: double.infinity,
                                height: 56,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xFF2563EB), // Azul fuerte
                                      Color(0xFF7C3AED), // Morado fuerte
                                    ],
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(0xFF2563EB).withOpacity(0.3),
                                      blurRadius: 15,
                                      offset: const Offset(0, 6),
                                    ),
                                  ],
                                ),
                                child: ElevatedButton(
                                  onPressed: _handleGoogleSignIn,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    shadowColor: Colors.transparent,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    padding: EdgeInsets.zero,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(6),
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(
                                          Icons.g_mobiledata_rounded,
                                          color: Colors.black87,
                                          size: 24,
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      const Text(
                                        'Continuar con Google',
                                        style: TextStyle(
                                          fontFamily: 'Inter',
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                          letterSpacing: 0.3,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
