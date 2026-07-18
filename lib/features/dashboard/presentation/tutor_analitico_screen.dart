import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:learn/core/config/neural_theme.dart';
import 'package:learn/providers/srs_provider.dart';
import 'package:learn/providers/quiz_provider.dart';
import 'package:learn/providers/gamification_provider.dart';
import 'package:learn/providers/subject_provider.dart';
import 'package:learn/features/dashboard/domain/study_stats_collector.dart';
import 'package:learn/screens/entrevista_simulator/puter_service.dart';
import 'package:learn/core/services/local_storage_service.dart';

class TutorAnaliticoScreen extends StatefulWidget {
  const TutorAnaliticoScreen({super.key});

  @override
  State<TutorAnaliticoScreen> createState() => _TutorAnaliticoScreenState();
}

class _TutorAnaliticoScreenState extends State<TutorAnaliticoScreen>
    with TickerProviderStateMixin {
  late final AnimationController _pulseCtrl;
  late final AnimationController _fadeCtrl;
  late final Animation<double> _pulseAnim;
  late final Animation<double> _fadeAnim;

  String _aiText = '';
  String _displayedText = '';
  bool _isLoading = true;
  bool _hasError = false;
  String _errorMsg = '';
  Map<String, dynamic> _visualStats = {};
  Timer? _typingTimer;
  String? _worstSubjectId;

  String _userName = 'Aspirante';
  String _targetSchool = 'EO PNP';

  @override
  void initState() {
    super.initState();
    _pulseCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    _fadeCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _fadeAnim = CurvedAnimation(parent: _fadeCtrl, curve: Curves.easeOutCubic);
    _pulseAnim = Tween<double>(
      begin: 0.95,
      end: 1.05,
    ).animate(CurvedAnimation(parent: _pulseCtrl, curve: Curves.easeInOutSine));

    final storage = context.read<LocalStorageService>();
    _userName = storage.loadUserName();
    _targetSchool = storage.loadTargetSchool();

    WidgetsBinding.instance.addPostFrameCallback((_) => _analyze());
  }

  @override
  void dispose() {
    _pulseCtrl.dispose();
    _fadeCtrl.dispose();
    _typingTimer?.cancel();
    super.dispose();
  }

  Future<void> _analyze({bool forceRefresh = false}) async {
    setState(() {
      _isLoading = true;
      _hasError = false;
      _aiText = '';
      _displayedText = '';
    });

    try {
      final srs = context.read<SrsProvider>();
      final quiz = context.read<QuizProvider>();
      final gami = context.read<GamificationProvider>();
      final subjectProv = context.read<SubjectProvider>();

      final collector = StudyStatsCollector(
        srs: srs,
        quiz: quiz,
        gamification: gami,
        subjects: subjectProv,
      );

      _visualStats = collector.buildVisualStats();
      _worstSubjectId = _visualStats['worstSubjectId'] as String?;

      final storage = context.read<LocalStorageService>();

      if (!forceRefresh) {
        final cachedText = storage.loadTutorAnalysis();
        final cachedTime = storage.loadTutorAnalysisTime();

        if (cachedText != null && cachedText.isNotEmpty && cachedTime != null) {
          final now = DateTime.now();
          if (now.difference(cachedTime).inHours < 24) {
            if (!mounted) return;
            setState(() {
              _isLoading = false;
              _aiText = cachedText;
            });
            _fadeCtrl.forward();
            _startTypingEffect(cachedText);
            return;
          }
        }
      }

      final statsJson = collector.buildStatsJson();
      final puter = PuterService();
      final result = await puter.generateTutorAnalysis(statsJson);

      storage.saveTutorAnalysis(result);

      if (!mounted) return;
      setState(() {
        _isLoading = false;
        _aiText = result;
      });
      _fadeCtrl.forward();
      _startTypingEffect(result);
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
        _hasError = true;
        _errorMsg = e.toString();
      });
    }
  }

  void _startTypingEffect(String text) {
    _displayedText = '';
    int i = 0;
    _typingTimer = Timer.periodic(const Duration(milliseconds: 18), (timer) {
      if (i < text.length) {
        if (mounted) {
          setState(() => _displayedText = text.substring(0, i + 1));
        }
        i++;
      } else {
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final nt = NeuralTheme.of(context);

    return Scaffold(
      backgroundColor: nt.background,
      body: Stack(
        children: [
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: const Alignment(-0.4, -0.6),
                  radius: 1.2,
                  colors: [
                    const Color(0xFF4F1B8F).withValues(alpha: 0.35),
                    nt.background,
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            right: -60,
            bottom: 80,
            child: RepaintBoundary(
              child: ScaleTransition(
                scale: _pulseAnim,
                child: Container(
                  width: 280,
                  height: 280,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        const Color(0xFF7C3AED).withValues(alpha: 0.18),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                _buildAppBar(context),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 12),
                        _buildAriaHeader(),
                        const SizedBox(height: 16),
                        Center(child: _buildProfileCard(nt)),
                        const SizedBox(height: 24),
                        if (_isLoading) _buildLoadingCard(nt),
                        if (_hasError) _buildErrorCard(nt),
                        if (!_isLoading && !_hasError) ...[
                          _buildMetricsRow(nt),
                          const SizedBox(height: 16),
                          _buildSubjectBars(nt),
                          const SizedBox(height: 16),
                          Center(
                            child: TextButton.icon(
                              onPressed: _isLoading
                                  ? null
                                  : () => _analyze(forceRefresh: true),
                              icon: const Icon(
                                Icons.refresh_rounded,
                                color: Colors.white54,
                                size: 20,
                              ),
                              label: const Text(
                                'Actualizar Análisis',
                                style: TextStyle(
                                  color: Colors.white54,
                                  fontFamily: 'Inter',
                                ),
                              ),
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.white.withValues(
                                  alpha: 0.05,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 12,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 80),
                          FadeTransition(
                            opacity: _fadeAnim,
                            child: _buildAiAdviceCard(nt),
                          ),
                          if (_worstSubjectId != null) ...[
                            const SizedBox(height: 16),
                            _buildActionCta(nt),
                          ],
                        ],
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          _glassButton(
            icon: Icons.arrow_back_ios_new_rounded,
            onTap: () => context.pop(),
          ),
          const Spacer(),
          const Text(
            'Tutor IA',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w700,
              fontFamily: 'Outfit',
            ),
          ),
          const Spacer(),
          _glassButton(icon: Icons.refresh_rounded, onTap: _analyze),
        ],
      ),
    );
  }

  Widget _glassButton({required IconData icon, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
        ),
        child: Icon(icon, color: Colors.white, size: 18),
      ),
    );
  }

  Widget _buildAriaHeader() {
    return Row(
      children: [
        RepaintBoundary(
          child: ScaleTransition(
            scale: _pulseAnim,
            child: Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  colors: [Color(0xFF7C3AED), Color(0xFFEC4899)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF7C3AED).withValues(alpha: 0.5),
                    blurRadius: 24,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: const Center(
                child: Text('🧠', style: TextStyle(fontSize: 32)),
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'ARIA',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'Outfit',
                  letterSpacing: 2,
                ),
              ),
              Text(
                'Tu Tutor Analítico Personalizado',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.6),
                  fontSize: 13,
                  fontFamily: 'Outfit',
                ),
              ),
              const SizedBox(height: 6),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 3,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF7C3AED).withValues(alpha: 0.25),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: const Color(0xFF7C3AED).withValues(alpha: 0.5),
                  ),
                ),
                child: const Text(
                  '✦ ANÁLISIS EN TIEMPO REAL',
                  style: TextStyle(
                    color: Color(0xFFC084FC),
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProfileCard(NeuralThemeData nt) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: nt.surfaceCard.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: nt.blueGoogle.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.school, color: nt.blueGoogle, size: 16),
          const SizedBox(width: 8),
          Text(
            '$_userName • $_targetSchool',
            style: TextStyle(
              color: nt.textPrimary,
              fontSize: 13,
              fontWeight: FontWeight.w600,
              fontFamily: 'Outfit',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingCard(NeuralThemeData nt) {
    return _glassCard(
      child: Column(
        children: [
          const SizedBox(height: 16),
          SizedBox(
            width: 48,
            height: 48,
            child: CircularProgressIndicator(
              color: const Color(0xFF7C3AED),
              strokeWidth: 3,
              backgroundColor: Colors.white.withValues(alpha: 0.08),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'ARIA está analizando tu progreso...',
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w600,
              fontFamily: 'Outfit',
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'Leyendo tus flashcards, sesiones de quiz\ny datos de gamificación.',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.5),
              fontSize: 13,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildErrorCard(NeuralThemeData nt) {
    return _glassCard(
      borderColor: Colors.redAccent.withValues(alpha: 0.4),
      child: Column(
        children: [
          const Icon(
            Icons.error_outline_rounded,
            color: Colors.redAccent,
            size: 40,
          ),
          const SizedBox(height: 12),
          const Text(
            'No se pudo conectar con ARIA',
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            _errorMsg,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.5),
              fontSize: 12,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          GestureDetector(
            onTap: _analyze,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
              decoration: BoxDecoration(
                color: const Color(0xFF7C3AED).withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                'Reintentar',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _buildMetricsRow(NeuralThemeData nt) {
    final level = _visualStats['level'] as int? ?? 1;
    final xp = _visualStats['xp'] as int? ?? 0;
    final streak = _visualStats['streak'] as int? ?? 0;
    final sessions = _visualStats['totalSessions'] as int? ?? 0;
    final globalAvg = _visualStats['globalAvg'] as double? ?? 0.0;
    final pending = _visualStats['pendingReviews'] as int? ?? 0;

    return Row(
      children: [
        Expanded(
          child: _metricCard(
            icon: '⚡',
            label: 'Nivel',
            value: '$level',
            sub: '$xp XP',
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _metricCard(
            icon: '🔥',
            label: 'Racha',
            value: '$streak',
            sub: 'días seguidos',
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _metricCard(
            icon: '🎯',
            label: 'Precisión',
            value: '${(globalAvg).toStringAsFixed(0)}%',
            sub: '$sessions sesiones',
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _metricCard(
            icon: '📚',
            label: 'Repasos',
            value: '$pending',
            sub: 'pendientes',
            accentColor: pending > 0 ? Colors.orangeAccent : nt.successGreen,
          ),
        ),
      ],
    );
  }

  Widget _metricCard({
    required String icon,
    required String label,
    required String value,
    required String sub,
    Color? accentColor,
  }) {
    final color = accentColor ?? const Color(0xFF7C3AED);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      ),
      child: Column(
        children: [
          Text(icon, style: const TextStyle(fontSize: 20)),
          const SizedBox(height: 6),
          Text(
            value,
            style: TextStyle(
              color: color,
              fontSize: 18,
              fontWeight: FontWeight.w800,
              fontFamily: 'Outfit',
            ),
          ),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            sub,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.4),
              fontSize: 10,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildSubjectBars(NeuralThemeData nt) {
    final performance =
        _visualStats['subjectPerformance'] as List<Map<String, dynamic>>? ?? [];
    if (performance.isEmpty) return const SizedBox.shrink();

    return _glassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Rendimiento por Materia',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w700,
              fontFamily: 'Outfit',
            ),
          ),
          const SizedBox(height: 16),
          ...performance.map((p) {
            final pct = ((p['avg'] as double).clamp(0.0, 100.0));
            final colorHex = p['color'] as String? ?? '#7C3AED';
            final barColor = _hexToColor(colorHex);
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        p['subject'] as String,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        '${pct.toStringAsFixed(0)}%',
                        style: TextStyle(
                          color: barColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: LinearProgressIndicator(
                      value: pct / 100,
                      backgroundColor: Colors.white.withValues(alpha: 0.08),
                      valueColor: AlwaysStoppedAnimation<Color>(barColor),
                      minHeight: 8,
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildAiAdviceCard(NeuralThemeData nt) {
    return _glassCard(
      borderColor: const Color(0xFF7C3AED).withValues(alpha: 0.5),
      gradient: LinearGradient(
        colors: [
          const Color(0xFF4F1B8F).withValues(alpha: 0.25),
          const Color(0xFF1E1B4B).withValues(alpha: 0.15),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFF7C3AED).withValues(alpha: 0.25),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text('🧠', style: TextStyle(fontSize: 18)),
              ),
              const SizedBox(width: 12),
              const Text(
                'Consejo de ARIA',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Outfit',
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: const Color(0xFF7C3AED).withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'IA',
                  style: TextStyle(
                    color: Color(0xFFC084FC),
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            _displayedText.isEmpty ? _aiText : _displayedText,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.85),
              fontSize: 14,
              height: 1.7,
              fontFamily: 'Outfit',
            ),
          ),
          if (_displayedText.length < _aiText.length &&
              _displayedText.isNotEmpty)
            const Padding(
              padding: EdgeInsets.only(top: 8),
              child: SizedBox(
                width: 20,
                child: LinearProgressIndicator(
                  color: Color(0xFF7C3AED),
                  backgroundColor: Colors.transparent,
                  minHeight: 2,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildActionCta(NeuralThemeData nt) {
    final subjectList = context.read<SubjectProvider>().subjects;
    final subject = subjectList
        .where((s) => s.id == _worstSubjectId)
        .firstOrNull;
    if (subject == null) return const SizedBox.shrink();

    return GestureDetector(
      onTap: () => context.push(
        '/topics',
        extra: {'subjectId': subject.id, 'mode': 'quiz'},
      ),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color(0xFFDC2626).withValues(alpha: 0.3),
              const Color(0xFF991B1B).withValues(alpha: 0.2),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: const Color(0xFFDC2626).withValues(alpha: 0.4),
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFFDC2626).withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.fitness_center_rounded,
                color: Colors.redAccent,
                size: 22,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '¡Practica tu materia débil!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Outfit',
                    ),
                  ),
                  Text(
                    subject.name,
                    style: const TextStyle(
                      color: Colors.redAccent,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              color: Colors.white54,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  Widget _glassCard({
    required Widget child,
    Color? borderColor,
    Gradient? gradient,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: gradient,
        color: gradient == null ? Colors.white.withValues(alpha: 0.05) : null,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: borderColor ?? Colors.white.withValues(alpha: 0.1),
        ),
      ),
      child: child,
    );
  }

  Color _hexToColor(String hex) {
    try {
      final h = hex.replaceFirst('#', '');
      return Color(int.parse('FF$h', radix: 16));
    } catch (_) {
      return const Color(0xFF7C3AED);
    }
  }
}
