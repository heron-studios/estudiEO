import 'package:flutter/material.dart';
import 'package:learn/core/services/local_storage_service.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
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
  final int _maxMessages = 5;
  bool _interviewFinished = false;
  bool _dailyLimitReached = false;

  final SpeechToText _speechToText = SpeechToText();
  bool _isListening = false;

  final String _systemPrompt = 
    'Actúa como un Coronel de la Policía Nacional del Perú (PNP) con más de 25 años de servicio ininterrumpido. Eres el Presidente de la Junta Evaluadora de la entrevista personal para el proceso de admisión a las Escuelas de Formación de la PNP (aplicable a Oficiales y Suboficiales).\n\n'
    'Tu Perfil y Actitud:\n'
    '- Imponente y Autoridad: Eres sumamente formal, directo y estricto. No tutéas al postulante; lo tratas de "Usted".\n'
    '- Observador Crítico: Analizas no solo lo que el postulante responde, sino cómo lo argumenta. Buscas fisuras en su ética, tolerancia a la frustración y verdadera vocación de servicio.\n'
    '- Cero Complacencia: No felicitas fácilmente. Si una respuesta es mediocre, te muestras escéptico y presionas con repreguntas.\n'
    '- Orgullo Institucional: Tienes un profundo respeto por la mística y doctrina policial. Desprecias la indisciplina y la corrupción.\n\n'
    'Contexto del Postulante: El candidato busca ingresar a la PNP. Esperas de él madurez, vocación de servicio y liderazgo.\n\n'
    'Instrucciones Estrictas para la Dinámica:\n'
    '1. Haz UNA SOLA PREGUNTA a la vez. Nunca envíes una lista de preguntas.\n'
    '2. Espera a que el postulante responda antes de continuar.\n'
    '3. Basado en su respuesta, realiza una repregunta incisiva o pasa a una nueva materia (Doctrina, Ética, Realidad Nacional, Liderazgo, Marco Legal).\n'
    '4. NO USES FORMATO MARKDOWN EN TUS RESPUESTAS (sin asteriscos para negritas, sin viñetas especiales). Responde únicamente en texto plano para mantener el realismo de una conversación hablada.\n\n'
    'El candidato acaba de tocar la puerta e ingresar a la sala de juntas. Da tu primera orden y haz tu primera pregunta para evaluar su motivación.';

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
    if (!auth.isPremium) {
      final canUseAI = await LimitsService.canUseIA();
      if (!canUseAI) {
        setState(() {
          _dailyLimitReached = true;
          _messages.add(ChatMessage(text: 'Mi Coronel: "Usted ya tuvo su oportunidad el día de hoy. Retírese y vuelva mañana con una mejor preparación."', isUser: false));
        });
        return;
      }
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
    
    String contextualizacion = voiceText != null 
        ? 'El candidato respondió en voz alta (transcripción automática): "$text"\nEvalúa su respuesta, incluyendo su fluidez y coherencia al hablar, y haz la siguiente pregunta.'
        : 'El candidato dice: "$text"\nEvalúa su respuesta y haz la siguiente pregunta.';
        
    String promptConContexto = '$_systemPrompt\n\n$contextualizacion';
    
    if (_messageCount >= _maxMessages) {
      promptConContexto = '$_systemPrompt\n\n$contextualizacion\n\nEsta es tu última intervención. Finaliza la entrevista y entrégale una rúbrica de evaluación detallada (del 1 al 20) destacando sus fortalezas, debilidades y áreas de estudio a reforzar.';
      _interviewFinished = true;
      
      // Registrar que ya hizo su entrevista del día
      if (mounted) {
        final auth = context.read<AuthService>();
        if (!auth.isPremium) {
          LimitsService.incrementIACount();
        }
        context.read<LocalStorageService>().saveLastInterviewDate(DateTime.now());
      }
    }
    
    final response = await _puterService.chat(promptConContexto);

    if (mounted) {
      setState(() {
        _messages.add(ChatMessage(text: response, isUser: false));
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
        scaffoldBackgroundColor: const Color(0xFF121212),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1E1E1E),
          elevation: 0,
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Simulador de Entrevista (Jurado)'),
          centerTitle: true,
        ),
        body: Stack(
          children: [
            // El WebView oculto si existe
            if (bridgeWidget != null)
              Positioned(
                top: -100, // Fuera de pantalla
                left: -100,
                child: bridgeWidget,
              ),
            
            Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.all(16.0),
                    itemCount: _messages.length,
                    itemBuilder: (context, index) {
                      final message = _messages[index];
                      return _buildMessageBubble(message);
                    },
                  ),
                ),
                if (_isLoading)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: CircularProgressIndicator(color: Colors.blueAccent),
                  ),
                _buildChatInput(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageBubble(ChatMessage message) {
    return Align(
      alignment: message.isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6.0),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        decoration: BoxDecoration(
          color: message.isUser ? Colors.blueAccent[700] : const Color(0xFF2C2C2C),
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: Radius.circular(message.isUser ? 16 : 0),
            bottomRight: Radius.circular(message.isUser ? 0 : 16),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              blurRadius: 4,
              offset: const Offset(0, 2),
            )
          ],
        ),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        child: Text(
          message.text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16.0,
            height: 1.4,
          ),
        ),
      ),
    );
  }

  Widget _buildChatInput() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        border: Border(top: BorderSide(color: Colors.grey[800]!)),
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _textController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Escribe tu respuesta...',
                  hintStyle: TextStyle(color: Colors.grey[500]),
                  filled: true,
                  fillColor: const Color(0xFF2C2C2C),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24.0),
                    borderSide: BorderSide.none,
                  ),
                ),
                onSubmitted: (_) => _sendMessage(),
                enabled: !_isLoading && !_interviewFinished && !_dailyLimitReached && !_isListening,
              ),
            ),
            const SizedBox(width: 8.0),
            CircleAvatar(
              backgroundColor: (_isLoading || _interviewFinished || _dailyLimitReached) ? Colors.grey : (_isListening ? Colors.redAccent : Colors.greenAccent[700]),
              child: IconButton(
                icon: Icon(_isListening ? Icons.mic : Icons.mic_none, color: Colors.white),
                onPressed: (_isLoading || _interviewFinished || _dailyLimitReached) 
                    ? null 
                    : (_isListening ? _stopListening : _startListening),
              ),
            ),
            const SizedBox(width: 8.0),
            CircleAvatar(
              backgroundColor: (_isLoading || _interviewFinished || _dailyLimitReached) ? Colors.grey : Colors.blueAccent,
              child: IconButton(
                icon: const Icon(Icons.send, color: Colors.white),
                onPressed: (_isLoading || _interviewFinished || _dailyLimitReached || _isListening) ? null : () => _sendMessage(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
