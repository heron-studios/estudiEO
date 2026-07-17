import 'package:flutter/material.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import 'package:learn/core/services/local_storage_service.dart';
import 'package:learn/models/interview_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:learn/core/services/limits_service.dart';
import 'package:learn/features/auth/domain/auth_service.dart';
import 'package:go_router/go_router.dart';
import 'puter_service.dart';

class ChatMessage {
  final String text;
  final bool isUser;

  ChatMessage({required this.text, required this.isUser});
}

class EntrevistaSimulatorScreen extends StatefulWidget {
  const EntrevistaSimulatorScreen({super.key});

  @override
  State<EntrevistaSimulatorScreen> createState() =>
      _EntrevistaSimulatorScreenState();
}

class _EntrevistaSimulatorScreenState
    extends State<EntrevistaSimulatorScreen> {
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  final List<ChatMessage> _messages = [];
  bool _isLoading = false;
  late final PuterService _puterService;

  int _messageCount = 0;
  // Pro: 7 preguntas (entrevista completa). Free: bloquear en 3
  final int _maxMessagesPro = 7;
  final int _maxMessagesFree = 3;
  bool _interviewFinished = false;
  bool _dailyLimitReached = false;
  bool _freeUpgradeWallShown = false; // Muro de actualización para free en pregunta 3

  int _cooldownRemaining = 0;
  Timer? _cooldownTimer;
  bool _isPremium = false;

  void _startCooldown(int seconds) {
    setState(() => _cooldownRemaining = seconds);
    _cooldownTimer?.cancel();
    _cooldownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) { timer.cancel(); return; }
      setState(() {
        _cooldownRemaining--;
        if (_cooldownRemaining <= 0) timer.cancel();
      });
    });
  }

  final SpeechToText _speechToText = SpeechToText();
  bool _isListening = false;

  // System prompt reforzado para incluir nota numérica obligatoria al final
  final String _systemPrompt =
      'Actúa como un exigente Coronel de la Policía Nacional del Perú (PNP) con más de 30 años de servicio, Presidente de la rigurosa Junta Evaluadora de la entrevista personal de admisión.\n\n'
      'Tu Perfil y Actitud:\n'
      '- Autoridad Implacable: Eres sumamente formal, cortante y directo. Exiges disciplina desde el primer segundo. Tratas al postulante de "Usted", jamás lo tutéas.\n'
      '- Inquisidor Estratégico: No te conformas con respuestas memorizadas. Interrumpes mentalmente la mediocridad buscando contradicciones, evaluando su temple, vocación real y ética intachable.\n'
      '- Cero Empatía Fingida: Si la respuesta es vacía o genérica, muestras tu decepción con frases cortas y repreguntas bajo presión.\n'
      '- Mística Institucional: Valoras el honor, el sacrificio y la lealtad a la PNP por encima de todo.\n\n'
      'Instrucciones CRÍTICAS de Formato:\n'
      '1. EXIGE respuestas. Haz UNA SOLA PREGUNTA o repregunta directa por mensaje. NUNCA envíes varias preguntas juntas.\n'
      '2. NO USES NINGÚN FORMATO MARKDOWN. Nada de asteriscos, negritas ni cursivas. Escribe en texto plano, como un guion de diálogo real.\n'
      '3. Si el postulante titubea o da respuestas "de manual", córtalo y ponlo en aprietos éticos o de liderazgo.\n'
      '4. REACCIONA ORGÁNICAMENTE. NUNCA empieces tus frases narrando lo que dijo el postulante. Empieza a hablar directamente y al grano como un Coronel humano.\n\n'
      'INSTRUCCIÓN PARA LA EVALUACIÓN FINAL: Cuando finalices la entrevista, incluye OBLIGATORIAMENTE la nota con el formato exacto: "NOTA FINAL: X/20" (donde X es un número del 0 al 20). Esta nota debe ser muy exigente y realista.\n\n'
      'El postulante acaba de pararse frente a ti en posición de atención. Da tu orden inicial con autoridad y lanza la primera pregunta para medir su verdadera vocación.';

  @override
  void initState() {
    super.initState();
    _puterService = PuterService();
    _initSpeech();
    _checkDailyLimit();
  }

  void _initSpeech() async {
    await _speechToText.initialize();
    if (mounted) setState(() {});
  }

  void _checkDailyLimit() async {
    final auth = context.read<AuthService>();
    _isPremium = auth.isPremium;
    final canUseAI = await LimitsService.canUseEntrevistaIA(_isPremium);
    if (!canUseAI) {
      final horasRestantes =
          await LimitsService.getHorasRestantesEntrevistaIA(_isPremium);
      final waitMessage = horasRestantes > 0
          ? 'Retírese, prepárese y vuelva en $horasRestantes horas'
          : 'Retírese y vuelva mañana';
      final waitLabel = _isPremium
          ? 'Ya usó su entrevista de hoy. Vuelva mañana.'
          : 'Ya usó su entrevista. Debe esperar 48 horas para el siguiente intento.';
      setState(() {
        _dailyLimitReached = true;
        _messages.add(ChatMessage(
            text:
                'Mi Coronel: "Usted ya tuvo su oportunidad. $waitLabel $waitMessage con una mejor preparación."',
            isUser: false));
      });
      return;
    }
    _startInterview();
  }

  void _startInterview() async {
    setState(() => _isLoading = true);
    final initialPrompt = '$_systemPrompt\n\nPor favor, inicia la entrevista.';
    final response = await _puterService.chat(initialPrompt);
    if (mounted) {
      setState(() {
        _messages.add(ChatMessage(text: response, isUser: false));
        _isLoading = false;
      });
      _scrollToBottom();
    }
  }

  /// Muestra el modal de "Actualiza a Pro" para usuarios free que llegaron al límite
  void _showUpgradeWall() {
    setState(() {
      _freeUpgradeWallShown = true;
      _interviewFinished = true; // Bloquear más respuestas
    });
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            color: const Color(0xFF1A1A2E),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: const Color(0xFF8B5CF6).withValues(alpha: 0.5),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF8B5CF6).withValues(alpha: 0.2),
                blurRadius: 40,
                spreadRadius: 10,
              )
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [Color(0xFF8B5CF6), Color(0xFF6D28D9)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: const Icon(Icons.star_rounded,
                    color: Colors.white, size: 36),
              ),
              const SizedBox(height: 20),
              const Text(
                '¡Límite de preguntas alcanzado!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Outfit',
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                'Los usuarios Free solo pueden responder 3 preguntas por intento.\n\nActualiza a Premium para completar la entrevista de 7 preguntas y obtener la evaluación final del Coronel con nota del 0 al 20.',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.75),
                  fontSize: 14,
                  height: 1.6,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                    context.push('/premium');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF8B5CF6),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: const Text(
                    '⭐ Actualizar a Premium',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Outfit',
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(),
                child: Text(
                  'Cerrar',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.5),
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Guarda el resultado de la entrevista en el historial local
  void _saveInterviewResult(String finalText) {
    final parsedScore = InterviewResult.parseScoreFromText(finalText);
    if (parsedScore == null) return; // Solo guardar si tenemos nota

    final result = InterviewResult(
      date: DateTime.now(),
      score: parsedScore,
      evaluation: finalText.length > 500
          ? '${finalText.substring(0, 497)}...'
          : finalText,
      messagesCount: _messageCount,
    );
    context.read<LocalStorageService>().saveInterviewResult(result);
  }

  void _sendMessage({String? voiceText}) async {
    final text = voiceText ?? _textController.text.trim();
    if (text.isEmpty) return;
    if (voiceText == null) _textController.clear();

    setState(() {
      _messages.add(ChatMessage(text: text, isUser: true));
      _isLoading = true;
    });
    _scrollToBottom();
    _messageCount++;

    // Descontar el intento al primer mensaje
    if (_messageCount == 1 && mounted) {
      final auth = context.read<AuthService>();
      LimitsService.incrementEntrevistaIACount(auth.isPremium);
      context.read<LocalStorageService>().saveLastInterviewDate(DateTime.now());
    }

    // Verificar límite para usuario Free (3 preguntas)
    final maxMessages = _isPremium ? _maxMessagesPro : _maxMessagesFree;
    final contextualizacion = voiceText != null
        ? '[El candidato responde en voz alta: "$text". Reacciona DIRECTAMENTE a sus palabras como humano sin repetir lo que dijo, juzga su nivel y lanza tu siguiente dardo/pregunta]'
        : '[El candidato dice: "$text". Reacciona DIRECTAMENTE de forma natural y lanza tu siguiente crítica/pregunta]';

    String promptConContexto = '$_systemPrompt\n\n$contextualizacion';

    bool isFinalMessage = _messageCount >= maxMessages;
    if (isFinalMessage) {
      promptConContexto =
          '$_systemPrompt\n\n$contextualizacion\n\n[INSTRUCCIÓN CRÍTICA DE SISTEMA]: Esta es tu última intervención. FINALIZA LA ENTREVISTA AHORA MISMO. Haz una auditoría final CRÍTICA, DURA Y SIN FILTROS de todas las respuestas del postulante. Dale una nota final del 0 al 20 siendo MUY REALISTA, estricto y exigente (es muy raro sacar 20). Destaca sus peores errores, sus debilidades y dile directamente si con ese nivel tiene futuro en la PNP o no. NO hagas más preguntas, solo despídelo con su dura evaluación final. OBLIGATORIO: Incluye "NOTA FINAL: X/20" al final.';
      _interviewFinished = true;
    }

    final response = await _puterService.chat(promptConContexto);

    String finalResponse = response;
    if (response.contains('429') ||
        response.contains('rate_limit') ||
        response.contains('Limit 12000')) {
      finalResponse =
          '[SILENCIO INCÓMODO]... El Coronel te observa fijamente mientras toma apuntes de tu actitud. (Has respondido muy rápido, por favor espera 15 segundos y reescribe tu respuesta).';
      _messageCount--;
      if (_interviewFinished) _interviewFinished = false;
      _startCooldown(15);
    } else {
      _startCooldown(8);
      // Si es el mensaje final y es premium, guardar resultado
      if (isFinalMessage && _isPremium) {
        _saveInterviewResult(finalResponse);
      }
    }

    if (mounted) {
      setState(() {
        _messages.add(ChatMessage(text: finalResponse, isUser: false));
        _isLoading = false;
      });
      _scrollToBottom();
    }

    // Si usuario Free llegó a 3 preguntas, mostrar muro de upgrade
    if (!_isPremium && _messageCount >= _maxMessagesFree && !_freeUpgradeWallShown && !response.contains('429')) {
      Future.delayed(const Duration(milliseconds: 800), () {
        if (mounted) _showUpgradeWall();
      });
    }
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _startListening() async {
    await _speechToText.listen(onResult: (result) {
      if (result.finalResult) _sendMessage(voiceText: result.recognizedWords);
    });
    setState(() => _isListening = true);
  }

  void _stopListening() async {
    await _speechToText.stop();
    setState(() => _isListening = false);
  }

  @override
  void dispose() {
    _cooldownTimer?.cancel();
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bridgeWidget = _puterService.buildBridgeWidget();

    return Theme(
      data: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF090A0C),
      ),
      child: PopScope(
        canPop: false,
        onPopInvokedWithResult: (bool didPop, Object? result) async {
          if (didPop) return;
          final navigator = Navigator.of(context);

          if (_messageCount > 0 && !_interviewFinished && !_dailyLimitReached) {
            final confirm = await showDialog<bool>(
              context: context,
              builder: (context) => AlertDialog(
                backgroundColor: const Color(0xFF1E1E24),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                title: const Row(children: [
                  Icon(Icons.warning_amber_rounded, color: Colors.orangeAccent),
                  SizedBox(width: 8),
                  Text('¿Abandonar?',
                      style: TextStyle(color: Colors.white, fontSize: 18)),
                ]),
                content: const Text(
                  'Si sales ahora perderás el progreso actual y se consumirá tu intento de entrevista.\n\n¿Estás seguro de querer salir?',
                  style:
                      TextStyle(color: Colors.white70, fontSize: 15, height: 1.4),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: const Text('Continuar Entrevista',
                        style: TextStyle(color: Colors.greenAccent)),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: const Text('Salir y perder intento',
                        style: TextStyle(color: Colors.redAccent)),
                  ),
                ],
              ),
            );
            if (confirm == true) navigator.pop();
          } else {
            navigator.pop();
          }
        },
        child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            title: const Text(
              'Junta Evaluadora PNP',
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                  fontSize: 18),
            ),
            centerTitle: true,
            // Fondo simple sin BackdropFilter para mejorar rendimiento web
            backgroundColor: const Color(0xFF090A0C).withValues(alpha: 0.9),
            elevation: 0,
            actions: [
              // Botón historial solo para Pro
              if (_isPremium)
                IconButton(
                  icon: const Icon(Icons.history_rounded,
                      color: Colors.white70),
                  tooltip: 'Historial de entrevistas',
                  onPressed: () =>
                      _showInterviewHistory(),
                ),
            ],
          ),
          body: Stack(
            children: [
              // Glows de fondo optimizados (sin blur)
              Positioned(
                top: -80,
                right: -40,
                child: Container(
                  width: 250,
                  height: 250,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFF004B23).withValues(alpha: 0.1),
                  ),
                ),
              ),
              Positioned(
                bottom: -40,
                left: -40,
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color:
                        const Color(0xFF0D47A1).withValues(alpha: 0.07),
                  ),
                ),
              ),

              if (bridgeWidget != null)
                Positioned(
                    top: -100, left: -100, child: bridgeWidget),

              Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 850),
                  child: SafeArea(
                    child: Column(
                      children: [
                        // Banner de límite para usuarios free
                        if (!_isPremium && !_dailyLimitReached)
                          _buildFreeBanner(),
                        Expanded(
                          child: ListView.builder(
                            controller: _scrollController,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 24.0),
                            itemCount: _messages.length,
                            itemBuilder: (context, index) {
                              final message = _messages[index];
                              return _buildMessageBubble(message);
                            },
                          ),
                        ),
                        if (_isLoading)
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 14,
                                  height: 14,
                                  child: CircularProgressIndicator(
                                      color: Colors.greenAccent,
                                      strokeWidth: 2),
                                ),
                                SizedBox(width: 12),
                                Text('El Coronel está evaluando...',
                                    style: TextStyle(
                                        color: Colors.white70, fontSize: 13)),
                              ],
                            ),
                          ),
                        _buildChatInput(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFreeBanner() {
    final remaining = (_maxMessagesFree - _messageCount).clamp(0, _maxMessagesFree);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: const Color(0xFF8B5CF6).withValues(alpha: 0.15),
      child: Row(
        children: [
          const Icon(Icons.info_outline_rounded,
              color: Color(0xFF8B5CF6), size: 16),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              'Plan Free: $remaining pregunta${remaining != 1 ? 's' : ''} restante${remaining != 1 ? 's' : ''}. Actualiza a Pro para la entrevista completa.',
              style: const TextStyle(
                  color: Color(0xFFBBA7F5), fontSize: 12),
            ),
          ),
          GestureDetector(
            onTap: () => context.push('/premium'),
            child: const Text('Ver Pro →',
                style: TextStyle(
                    color: Color(0xFF8B5CF6),
                    fontSize: 12,
                    fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  void _showInterviewHistory() {
    final history =
        context.read<LocalStorageService>().getInterviewHistory();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        height: MediaQuery.of(context).size.height * 0.75,
        decoration: const BoxDecoration(
          color: Color(0xFF13131A),
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                '📊 Historial de Entrevistas',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Outfit',
                ),
              ),
            ),
            if (history.isEmpty)
              const Expanded(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('🎖️', style: TextStyle(fontSize: 48)),
                      SizedBox(height: 12),
                      Text(
                        'Aún no tienes entrevistas guardadas.\nCompleta una entrevista para ver tu progreso.',
                        style: TextStyle(color: Colors.white54, fontSize: 14),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              )
            else
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: history.length,
                  itemBuilder: (ctx, i) {
                    final r = history[i];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1E1E28),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color:
                              r.scoreColor.withValues(alpha: 0.3),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 56,
                            height: 56,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: r.scoreColor.withValues(alpha: 0.15),
                              border: Border.all(
                                  color: r.scoreColor.withValues(alpha: 0.5)),
                            ),
                            child: Center(
                              child: Text(
                                '${r.score.toInt()}',
                                style: TextStyle(
                                  color: r.scoreColor,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      r.scoreLabel,
                                      style: TextStyle(
                                        color: r.scoreColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      '${r.score.toStringAsFixed(0)}/20',
                                      style: const TextStyle(
                                        color: Colors.white70,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  r.formattedDate,
                                  style: const TextStyle(
                                    color: Colors.white38,
                                    fontSize: 12,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '${r.messagesCount} preguntas respondidas',
                                  style: const TextStyle(
                                    color: Colors.white38,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Tendencia
                          if (i < history.length - 1)
                            Icon(
                              history[i].score >= history[i + 1].score
                                  ? Icons.trending_up_rounded
                                  : Icons.trending_down_rounded,
                              color: history[i].score >= history[i + 1].score
                                  ? Colors.greenAccent
                                  : Colors.redAccent,
                              size: 20,
                            ),
                        ],
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageBubble(ChatMessage message) {
    return Align(
      alignment:
          message.isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: RepaintBoundary(
        child: Container(
          margin: const EdgeInsets.only(bottom: 16.0),
          padding:
              const EdgeInsets.symmetric(horizontal: 18.0, vertical: 14.0),
          decoration: BoxDecoration(
            color: message.isUser
                ? const Color(0xFF1B5E20).withValues(alpha: 0.85)
                : const Color(0xFF1E1E24).withValues(alpha: 0.7),
            border: Border.all(
              color: message.isUser
                  ? Colors.greenAccent.withValues(alpha: 0.3)
                  : Colors.white.withValues(alpha: 0.05),
              width: 1.0,
            ),
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(20),
              topRight: const Radius.circular(20),
              bottomLeft: Radius.circular(message.isUser ? 20 : 4),
              bottomRight: Radius.circular(message.isUser ? 4 : 20),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 10,
                offset: const Offset(0, 4),
              )
            ],
          ),
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width >= 800
                ? 600
                : MediaQuery.of(context).size.width * 0.85,
          ),
          child: Text(
            message.text,
            style: TextStyle(
              color: message.isUser
                  ? Colors.white
                  : Colors.white.withValues(alpha: 0.9),
              fontSize: 15.0,
              height: 1.5,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildChatInput() {
    final bool inputBlocked = _isLoading ||
        _interviewFinished ||
        _dailyLimitReached ||
        _isListening ||
        _cooldownRemaining > 0;

    return Container(
      padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 16.0),
      decoration: BoxDecoration(
        // Sin BackdropFilter para mejor rendimiento en web
        color: const Color(0xFF090A0C).withValues(alpha: 0.95),
        border:
            Border(top: BorderSide(color: Colors.white.withValues(alpha: 0.07))),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF1A1A1F).withValues(alpha: 0.8),
                  borderRadius: BorderRadius.circular(24.0),
                  border: Border.all(
                      color: Colors.white.withValues(alpha: 0.08), width: 1),
                ),
                child: TextField(
                  controller: _textController,
                  style:
                      const TextStyle(color: Colors.white, fontSize: 15),
                  maxLines: 4,
                  minLines: 1,
                  textInputAction: TextInputAction.send,
                  onSubmitted: (_) => inputBlocked ? null : _sendMessage(),
                  decoration: InputDecoration(
                    hintText: _cooldownRemaining > 0
                        ? 'Espera $_cooldownRemaining s...'
                        : 'Diríjase al Coronel...',
                    hintStyle: TextStyle(
                        color: Colors.white.withValues(alpha: 0.3),
                        fontSize: 15),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 18.0, vertical: 14.0),
                    border: InputBorder.none,
                  ),
                  enabled: !inputBlocked,
                ),
              ),
            ),
            const SizedBox(width: 10.0),
            GestureDetector(
              onTap: (inputBlocked)
                  ? null
                  : (_isListening ? _stopListening : _startListening),
              child: Container(
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.only(bottom: 2),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: _isListening
                      ? const LinearGradient(
                          colors: [Colors.redAccent, Colors.deepOrange])
                      : LinearGradient(colors: [
                          Colors.white.withValues(alpha: 0.1),
                          Colors.white.withValues(alpha: 0.05)
                        ]),
                  border: Border.all(
                    color: _isListening
                        ? Colors.redAccent.withValues(alpha: 0.5)
                        : Colors.white.withValues(alpha: 0.1),
                  ),
                ),
                child: Icon(
                  _isListening
                      ? Icons.stop_circle_outlined
                      : Icons.mic_rounded,
                  color: _isListening ? Colors.white : Colors.white70,
                  size: 24,
                ),
              ),
            ),
            const SizedBox(width: 8.0),
            GestureDetector(
              onTap: inputBlocked ? null : () => _sendMessage(),
              child: Container(
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.only(bottom: 2),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    colors: [Color(0xFF2E7D32), Color(0xFF1B5E20)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF2E7D32).withValues(alpha: 0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    )
                  ],
                ),
                child: const Icon(Icons.send_rounded,
                    color: Colors.white, size: 24),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
