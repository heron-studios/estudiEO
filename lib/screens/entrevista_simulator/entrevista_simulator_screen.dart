import 'package:flutter/material.dart';
import 'dart:ui';
import 'dart:async';
import 'package:provider/provider.dart';
import 'package:learn/core/services/local_storage_service.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:learn/core/services/limits_service.dart';
import 'package:learn/features/auth/domain/auth_service.dart';
import 'puter_service.dart';
class ChatMessage {
  final String text;
  final bool isUser;
  
  ChatMessage({required this.text, required this.isUser});
}

class EntrevistaSimulatorScreen extends StatefulWidget {
  const EntrevistaSimulatorScreen({super.key});

  @override
  State<EntrevistaSimulatorScreen> createState() => _EntrevistaSimulatorScreenState();
}

class _EntrevistaSimulatorScreenState extends State<EntrevistaSimulatorScreen> {
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  
  final List<ChatMessage> _messages = [];
  bool _isLoading = false;
  late final PuterService _puterService;
  
  int _messageCount = 0;
  final int _maxMessages = 7;
  bool _interviewFinished = false;
  bool _dailyLimitReached = false;

  int _cooldownRemaining = 0;
  Timer? _cooldownTimer;

  void _startCooldown(int seconds) {
    setState(() {
      _cooldownRemaining = seconds;
    });
    _cooldownTimer?.cancel();
    _cooldownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      setState(() {
        _cooldownRemaining--;
        if (_cooldownRemaining <= 0) {
          timer.cancel();
        }
      });
    });
  }

  final SpeechToText _speechToText = SpeechToText();
  bool _isListening = false;

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
    '4. REACCIONA ORGÁNICAMENTE. NUNCA empieces tus frases narrando lo que dijo el postulante (ej. "Usted respondió que...", "Según su respuesta..."). Empieza a hablar directamente y al grano como un Coronel humano. Si dice algo inaceptable o mediocre, lánzale la crítica o reprimenda de inmediato.\n\n'
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
    setState(() {});
  }

  void _checkDailyLimit() async {
    final auth = context.read<AuthService>();
    final canUseAI = await LimitsService.canUseEntrevistaIA(auth.isPremium);
    if (!canUseAI) {
      final horasRestantes = await LimitsService.getHorasRestantesEntrevistaIA(auth.isPremium);
      final waitMessage = horasRestantes > 0 
          ? 'Retírese, prepárese y vuelva en $horasRestantes horas' 
          : 'Retírese y vuelva mañana';

      setState(() {
        _dailyLimitReached = true;
        _messages.add(ChatMessage(
            text: 'Mi Coronel: "Usted ya tuvo su oportunidad. Ha agotado sus entrevistas. $waitMessage con una mejor preparación."',
            isUser: false));
      });
      return;
    }
    _startInterview();
  }

  void _startInterview() async {
    setState(() {
      _isLoading = true;
    });

    // Enviar el system prompt como la primera interacción oculta,
    // y pedirle que inicie la entrevista.
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
    
    // Descontar el intento apenas envía el primer mensaje para ser estrictos
    if (_messageCount == 1 && mounted) {
      final auth = context.read<AuthService>();
      LimitsService.incrementEntrevistaIACount(auth.isPremium);
      context.read<LocalStorageService>().saveLastInterviewDate(DateTime.now());
    }
    
    String contextualizacion = voiceText != null 
        ? '[El candidato responde en voz alta: "$text". Reacciona DIRECTAMENTE a sus palabras como humano sin repetir lo que dijo, juzga su nivel y lanza tu siguiente dardo/pregunta]'
        : '[El candidato dice: "$text". Reacciona DIRECTAMENTE de forma natural y lanza tu siguiente crítica/pregunta]';
        
    String promptConContexto = '$_systemPrompt\n\n$contextualizacion';
    
    if (_messageCount >= _maxMessages) {
      promptConContexto = '$_systemPrompt\n\n$contextualizacion\n\n[INSTRUCCIÓN CRÍTICA DE SISTEMA]: Esta es tu última intervención. FINALIZA LA ENTREVISTA AHORA MISMO. Haz una auditoría final CRÍTICA, DURA Y SIN FILTROS de todas las respuestas del postulante. Dale una nota final del 0 al 20 siendo MUY REALISTA, estricto y exigente (es muy raro sacar 20). Destaca sus peores errores, sus debilidades y dile directamente si con ese nivel tiene futuro en la PNP o no. NO hagas más preguntas, solo despídelo con su dura evaluación final.';
      _interviewFinished = true;
    }
    
    final response = await _puterService.chat(promptConContexto);

    String finalResponse = response;
    if (response.contains('429') || response.contains('rate_limit') || response.contains('Limit 12000')) {
      finalResponse = '[SILENCIO INCÓMODO]... El Coronel te observa fijamente mientras toma apuntes de tu actitud. (Has respondido muy rápido, por favor espera 15 segundos y reescribe tu respuesta).';
      _messageCount--; // Revertir el conteo ya que no fue procesado adecuadamente
      if (_interviewFinished) {
         _interviewFinished = false;
      }
      _startCooldown(15);
    } else {
      _startCooldown(8); // Cooldown preventivo de 8 segundos
    }

    if (mounted) {
      setState(() {
        _messages.add(ChatMessage(text: finalResponse, isUser: false));
        _isLoading = false;
      });
      _scrollToBottom();
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
      if (result.finalResult) {
        _sendMessage(voiceText: result.recognizedWords);
      }
    });
    setState(() {
      _isListening = true;
    });
  }

  void _stopListening() async {
    await _speechToText.stop();
    setState(() {
      _isListening = false;
    });
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
    // Obtenemos el widget puente (será nulo en web, un WebView en móviles)
    final bridgeWidget = _puterService.buildBridgeWidget();

    return Theme(
      // Forzamos el tema oscuro para esta pantalla según requerimiento
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
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                title: const Row(
                  children: [
                    Icon(Icons.warning_amber_rounded, color: Colors.orangeAccent),
                    SizedBox(width: 8),
                    Text('¿Abandonar?', style: TextStyle(color: Colors.white, fontSize: 18)),
                  ]
                ),
                content: const Text(
                  'Si sales ahora perderás el progreso actual y se consumirá tu intento de entrevista (cada mensaje procesado consume tokens valiosos).\n\n¿Estás seguro de querer salir?',
                  style: TextStyle(color: Colors.white70, fontSize: 15, height: 1.4),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: const Text('Continuar Entrevista', style: TextStyle(color: Colors.greenAccent)),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: const Text('Salir y perder intento', style: TextStyle(color: Colors.redAccent)),
                  ),
                ],
              ),
            );

            if (confirm == true) {
              navigator.pop();
            }
          } else {
            navigator.pop();
          }
        },
        child: Scaffold(
          extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: const Text(
            'Junta Evaluadora PNP',
            style: TextStyle(fontWeight: FontWeight.w600, letterSpacing: 0.5, fontSize: 18),
          ),
          centerTitle: true,
          backgroundColor: const Color(0xFF090A0C).withValues(alpha: 0.65),
          elevation: 0,
          flexibleSpace: ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
              child: Container(color: Colors.transparent),
            ),
          ),
        ),
        body: Stack(
          children: [
            // Fondo con glows sutiles (Glassmorphism)
            Positioned(
              top: -100,
              right: -50,
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFF004B23).withValues(alpha: 0.12), // Verde oscuro PNP
                  boxShadow: [
                    BoxShadow(color: const Color(0xFF004B23).withValues(alpha: 0.12), blurRadius: 100, spreadRadius: 50)
                  ]
                ),
              ),
            ),
            Positioned(
              bottom: -50,
              left: -50,
              child: Container(
                width: 250,
                height: 250,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFF0D47A1).withValues(alpha: 0.08), // Azul PNP oscuro
                  boxShadow: [
                    BoxShadow(color: const Color(0xFF0D47A1).withValues(alpha: 0.08), blurRadius: 80, spreadRadius: 40)
                  ]
                ),
              ),
            ),

            // El WebView oculto si existe
            if (bridgeWidget != null)
              Positioned(
                top: -100, // Fuera de pantalla
                left: -100,
                child: bridgeWidget,
              ),
            
            SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      controller: _scrollController,
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
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
                              width: 14, height: 14,
                              child: CircularProgressIndicator(color: Colors.greenAccent, strokeWidth: 2),
                            ),
                            SizedBox(width: 12),
                            Text('El Coronel está evaluando...', style: TextStyle(color: Colors.white70, fontSize: 13)),
                         ]
                      )
                    ),
                  _buildChatInput(),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }

  Widget _buildMessageBubble(ChatMessage message) {
    return Align(
      alignment: message.isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: RepaintBoundary(
        child: Container(
          margin: const EdgeInsets.only(bottom: 16.0),
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 14.0),
          decoration: BoxDecoration(
            color: message.isUser 
                ? const Color(0xFF1B5E20).withValues(alpha: 0.85) // Verde oscuro 
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
            maxWidth: MediaQuery.of(context).size.width * 0.85,
          ),
          child: Text(
            message.text,
            style: TextStyle(
              color: message.isUser ? Colors.white : Colors.white.withValues(alpha: 0.9),
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
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 16.0),
          decoration: BoxDecoration(
            color: const Color(0xFF090A0C).withValues(alpha: 0.7),
            border: Border(top: BorderSide(color: Colors.white.withValues(alpha: 0.05))),
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
                      border: Border.all(color: Colors.white.withValues(alpha: 0.08), width: 1),
                    ),
                    child: TextField(
                      controller: _textController,
                      style: const TextStyle(color: Colors.white, fontSize: 15),
                      maxLines: 4,
                      minLines: 1,
                      textInputAction: TextInputAction.send,
                      onSubmitted: (_) => _sendMessage(),
                      decoration: InputDecoration(
                        hintText: _cooldownRemaining > 0 ? 'Espera $_cooldownRemaining s...' : 'Diríjase al Coronel...',
                        hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.3), fontSize: 15),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 14.0),
                        border: InputBorder.none,
                      ),
                      enabled: !_isLoading && !_interviewFinished && !_dailyLimitReached && !_isListening && _cooldownRemaining <= 0,
                    ),
                  ),
                ),
                const SizedBox(width: 10.0),
                GestureDetector(
                  onTap: (_isLoading || _interviewFinished || _dailyLimitReached || _cooldownRemaining > 0) 
                      ? null 
                      : (_isListening ? _stopListening : _startListening),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.only(bottom: 2),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: _isListening 
                          ? const LinearGradient(colors: [Colors.redAccent, Colors.deepOrange])
                          : LinearGradient(colors: [
                              Colors.white.withValues(alpha: 0.1), 
                              Colors.white.withValues(alpha: 0.05)
                            ]),
                      border: Border.all(
                        color: _isListening ? Colors.redAccent.withValues(alpha: 0.5) : Colors.white.withValues(alpha: 0.1),
                      ),
                    ),
                    child: Icon(
                      _isListening ? Icons.stop_circle_outlined : Icons.mic_rounded, 
                      color: _isListening ? Colors.white : Colors.white70,
                      size: 24,
                    ),
                  ),
                ),
                const SizedBox(width: 8.0),
                GestureDetector(
                  onTap: (_isLoading || _interviewFinished || _dailyLimitReached || _isListening || _cooldownRemaining > 0) ? null : () => _sendMessage(),
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
                      ]
                    ),
                    child: const Icon(
                      Icons.send_rounded, 
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
