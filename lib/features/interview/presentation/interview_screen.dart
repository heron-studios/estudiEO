import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:learn/core/services/local_storage_service.dart';
import 'package:learn/core/services/audio_service.dart';
import 'package:learn/features/interview/domain/models/interview_question.dart';
import 'package:learn/features/interview/domain/services/interview_service.dart';
import 'package:learn/core/config/neural_theme.dart';

// Componente animado: Micrófono palpitante
class _PulsingMic extends StatefulWidget {
  final NeuralThemeData nt;
  const _PulsingMic({required this.nt});
  @override
  State<_PulsingMic> createState() => _PulsingMicState();
}
class _PulsingMicState extends State<_PulsingMic> with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(seconds: 1))..repeat(reverse: true);
  }
  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (context, child) {
        return Transform.scale(
          scale: 1.0 + (_ctrl.value * 0.15),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: widget.nt.pink.withValues(alpha: 0.1 + (_ctrl.value * 0.2)),
              boxShadow: [
                BoxShadow(
                  color: widget.nt.pink.withValues(alpha: _ctrl.value * 0.4),
                  blurRadius: 20,
                  spreadRadius: _ctrl.value * 10,
                )
              ],
            ),
            child: Icon(Icons.mic_rounded, color: widget.nt.pink, size: 36),
          ),
        );
      },
    );
  }
}

class InterviewScreen extends StatefulWidget {
  const InterviewScreen({super.key});

  @override
  State<InterviewScreen> createState() => _InterviewScreenState();
}

class _InterviewScreenState extends State<InterviewScreen> with TickerProviderStateMixin {
  final PageController _pageController = PageController();
  late final InterviewService _service;
  
  List<InterviewQuestion> _questions = [];
  int _currentIndex = 0;
  bool _showAnswer = false;
  bool _isLoading = true;

  // Realism Mode Vars
  bool _isRealismMode = false;
  Timer? _countdownTimer;
  double _timerProgress = 1.0;
  
  // Tracking
  int _sessionQuestionsAnswered = 0;
  int _sessionMastered = 0;
  int _sessionTimeouts = 0;
  int _sessionSkipped = 0;

  @override
  void initState() {
    super.initState();
    final storage = context.read<LocalStorageService>();
    _service = InterviewService(storage);
    _isRealismMode = storage.getInterviewRealismMode();
    _loadQuestions();
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    super.dispose();
  }

  Future<void> _loadQuestions() async {
    final q = await _service.getAvailableQuestions();
    if (mounted) {
      setState(() {
        _questions = q;
        _isLoading = false;
        _currentIndex = 0;
      });
      if (_pageController.hasClients) _pageController.jumpToPage(0);
      _startTimer();
    }
  }

  void _startTimer() {
    _countdownTimer?.cancel();
    if (!_isRealismMode || _questions.isEmpty || _showAnswer) return;

    setState(() => _timerProgress = 1.0);
    const duration = Duration(seconds: 30);
    final startTime = DateTime.now();

    _countdownTimer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      final elapsed = DateTime.now().difference(startTime);
      final remaining = duration.inMilliseconds - elapsed.inMilliseconds;
      
      if (remaining <= 0) {
        timer.cancel();
        _handleTimeout();
      } else {
        setState(() {
          _timerProgress = remaining / duration.inMilliseconds;
        });
        // Vibrar en los últimos 3 segundos
        if (remaining < 3000 && remaining % 500 < 50) {
          HapticFeedback.lightImpact();
        }
      }
    });
  }

  void _handleTimeout() {
    if (!mounted) return;
    HapticFeedback.vibrate();
    context.read<AudioService>().playIncorrectSound();
    _sessionTimeouts++;
    _sessionQuestionsAnswered++;
    _nextQuestion();
  }

  void _showFinalResults() {
    _countdownTimer?.cancel();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => _ResultsSummaryScreen(
        total: _sessionQuestionsAnswered,
        mastered: _sessionMastered,
        timeouts: _sessionTimeouts,
        skipped: _sessionSkipped,
      )),
    );
  }

  Future<void> _markMastered(int id) async {
    _countdownTimer?.cancel();
    context.read<AudioService>().playCorrectSound();
    _sessionMastered++;
    _sessionQuestionsAnswered++;
    await _service.markAsMastered(id);
    _nextQuestion();
  }

  void _markSkipped() {
    _sessionSkipped++;
    _sessionQuestionsAnswered++;
    _nextQuestion();
  }

  void _nextQuestion() {
    _countdownTimer?.cancel();
    if (_currentIndex < _questions.length - 1) {
      _pageController.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.easeInOutQuart);
    } else {
      _showFinalResults(); 
    }
  }

  @override
  Widget build(BuildContext context) {
    final nt = NeuralTheme.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded, color: isDark ? Colors.white : Colors.black87),
          onPressed: () {
            if (_sessionQuestionsAnswered > 0) {
              _showFinalResults();
            } else {
              Navigator.pop(context);
            }
          },
        ),
        title: const Text('SIMULADOR TÁCTICO', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 14, letterSpacing: 2.0)),
      ),
      body: Stack(
        children: [
          Positioned.fill(child: Container(color: nt.background)),
          _isLoading 
            ? Center(child: CircularProgressIndicator(color: nt.blueGoogle))
            : _questions.isEmpty 
              ? _buildAllMasteredState(nt, isDark)
              : SafeArea(
                  child: Column(
                    children: [
                      if (_isRealismMode) _buildRealismTimer(nt),
                      _buildProgressHeader(nt),
                      Expanded(
                        child: PageView.builder(
                          controller: _pageController,
                          physics: const NeverScrollableScrollPhysics(),
                          onPageChanged: (idx) => setState(() {
                            _currentIndex = idx;
                            _showAnswer = false;
                            _startTimer();
                          }),
                          itemCount: _questions.length,
                          itemBuilder: (context, index) => _buildQuestionView(_questions[index], nt, isDark),
                        ),
                      ),
                      _buildTacticalControls(nt, isDark),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
        ],
      ),
    );
  }

  Widget _buildRealismTimer(NeuralThemeData nt) {
    Color timerColor = _timerProgress < 0.2 ? nt.pink : nt.successGreen;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.timer_rounded, size: 14, color: timerColor),
              const SizedBox(width: 6),
              Text('TIEMPO DE REACCIÓN', 
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.w900, color: timerColor)),
            ],
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(2),
            child: LinearProgressIndicator(
              value: _timerProgress,
              minHeight: 4,
              backgroundColor: Colors.white10,
              valueColor: AlwaysStoppedAnimation<Color>(timerColor),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressHeader(NeuralThemeData nt) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 15, 30, 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('SIMULACRO ACTIVO', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 10, color: nt.blueGoogle)),
          Text('${_currentIndex + 1} / ${_questions.length}', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _buildQuestionView(InterviewQuestion q, NeuralThemeData nt, bool isDark) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(30),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
            decoration: BoxDecoration(
              color: nt.blueGoogle.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: nt.blueGoogle.withValues(alpha: 0.3)),
            ),
            child: Text(q.categoria.toUpperCase(), style: TextStyle(color: nt.blueGoogle, fontWeight: FontWeight.w900, fontSize: 9, letterSpacing: 1.2)),
          ),
          const SizedBox(height: 30),
          
          TweenAnimationBuilder(
            tween: Tween<double>(begin: 0, end: _showAnswer ? 1 : 0),
            duration: const Duration(milliseconds: 600),
            curve: Curves.easeInOutBack,
            builder: (context, double val, child) {
              final isUnder = val > 0.5;
              final tilt = ((val - 0.5).abs() - 0.5) * 0.002;
              final rotationY = val * math.pi;

              return Transform(
                transform: Matrix4.rotationY(rotationY)..setEntry(3, 0, tilt),
                alignment: Alignment.center,
                child: isUnder
                    ? Transform(
                        transform: Matrix4.rotationY(math.pi),
                        alignment: Alignment.center,
                        child: _buildAnswerCard(q, nt, isDark),
                      )
                    : _buildQuestionCard(q, nt, isDark),
              );
            },
          ),
          const SizedBox(height: 40),
          
          if (!_showAnswer) ...[
            _PulsingMic(nt: nt),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                _countdownTimer?.cancel();
                setState(() => _showAnswer = true);
              },
              icon: const Icon(Icons.psychology_alt_rounded),
              label: const Text('¿CÓMO RESPONDER?', style: TextStyle(fontWeight: FontWeight.w900)),
              style: ElevatedButton.styleFrom(
                backgroundColor: nt.blueGoogle, foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                elevation: 10,
                shadowColor: nt.blueGoogle.withValues(alpha: 0.5),
              ),
            ),
          ]
        ],
      ),
    );
  }

  Widget _buildQuestionCard(InterviewQuestion q, NeuralThemeData nt, bool isDark) {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(minHeight: 280),
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: isDark ? nt.surfaceCard : Colors.white.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: nt.blueGoogle.withValues(alpha: 0.4), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: nt.blueGoogle.withValues(alpha: 0.15),
            blurRadius: 30,
            offset: const Offset(0, 15),
          )
        ],
      ),
      child: Center(
        child: Text(q.pregunta, textAlign: TextAlign.center,
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, height: 1.4, color: isDark ? Colors.white : Colors.black87)),
      ),
    );
  }

  Widget _buildAnswerCard(InterviewQuestion q, NeuralThemeData nt, bool isDark) {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(minHeight: 280),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: isDark ? nt.surfaceCard : Colors.white.withValues(alpha: 0.95),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: nt.successGreen.withValues(alpha: 0.4), width: 2),
        boxShadow: [
          BoxShadow(color: nt.successGreen.withValues(alpha: 0.15), blurRadius: 30, offset: const Offset(0, 15))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildInfoCard('ENFOQUE TÁCTico', q.puntosClave, nt.warningAmber, isDark),
          const SizedBox(height: 16),
          _buildInfoCard('LENGUAJE NATURAL', q.respuestaIdeal, nt.successGreen, isDark),
        ],
      ),
    );
  }

  Widget _buildInfoCard(String title, String content, Color color, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title.toUpperCase(), style: TextStyle(color: color, fontWeight: FontWeight.w900, fontSize: 10)),
          const SizedBox(height: 8),
          Text(content, style: TextStyle(fontSize: 13, height: 1.5, color: isDark ? Colors.white70 : Colors.black87)),
        ],
      ),
    );
  }

  Widget _buildTacticalControls(NeuralThemeData nt, bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: _markSkipped,
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: isDark ? Colors.white24 : Colors.black26),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              child: const Text('MÁS ADELANTE', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w900, fontSize: 12)),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: ElevatedButton(
              onPressed: () => _markMastered(_questions[_currentIndex].id),
              style: ElevatedButton.styleFrom(
                backgroundColor: nt.successGreen,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                elevation: 8,
                shadowColor: nt.successGreen.withValues(alpha: 0.4),
              ),
              child: const Text('LO TENGO ✓', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 12)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAllMasteredState(NeuralThemeData nt, bool isDark) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.verified_user_rounded, size: 100, color: nt.successGreen),
            const SizedBox(height: 24),
            Text('¡BANCO DOMINADO!', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: isDark ? Colors.white : Colors.black87)),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () => Navigator.pop(context), 
              style: ElevatedButton.styleFrom(backgroundColor: nt.blueGoogle, foregroundColor: Colors.white),
              child: const Text('VOLVER AL DASHBOARD')
            ),
          ],
        ),
      ),
    );
  }
}

class _ResultsSummaryScreen extends StatelessWidget {
  final int total;
  final int mastered;
  final int timeouts;
  final int skipped;

  const _ResultsSummaryScreen({
    required this.total, 
    required this.mastered, 
    required this.timeouts,
    required this.skipped,
  });

  @override
  Widget build(BuildContext context) {
    final nt = NeuralTheme.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: nt.background,
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0, centerTitle: true, title: const Text('RESULTADOS DE SESIÓN', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 14))),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: Container(
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              color: isDark ? nt.surfaceCard : Colors.white,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: nt.blueGoogle.withValues(alpha: 0.3)),
              boxShadow: [
                BoxShadow(color: nt.blueGoogle.withValues(alpha: 0.1), blurRadius: 20, offset: const Offset(0, 10))
              ]
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.analytics_rounded, size: 60, color: nt.blueGoogle),
                const SizedBox(height: 20),
                _resultRow('Preguntas analizadas', '$total', nt.blueGoogle),
                const Divider(color: Colors.white24, height: 30),
                _resultRow('Dominadas (Aprendido)', '$mastered', nt.successGreen),
                _resultRow('Sin respuesta (Timeout)', '$timeouts', nt.pink),
                _resultRow('Saltadas para luego', '$skipped', nt.warningAmber),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(backgroundColor: nt.blueGoogle, foregroundColor: Colors.white, minimumSize: const Size(double.infinity, 60)),
                  child: const Text('FINALIZAR ENTRENAMIENTO', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _resultRow(String label, String val, Color color) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 12),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.grey)),
        Text(val, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: color)),
      ],
    ),
  );
}
