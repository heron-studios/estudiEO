import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:learn/core/config/neural_theme.dart';
import 'package:learn/core/widgets/neural_background_wrapper.dart';
import 'package:learn/core/services/ai_tactical_service.dart';
import 'package:learn/core/services/api_key_storage.dart';

class RedaccionPage extends StatefulWidget {
  const RedaccionPage({super.key});

  @override
  State<RedaccionPage> createState() => _RedaccionPageState();
}

class _RedaccionPageState extends State<RedaccionPage> {
  final _originalController = TextEditingController();
  final _iaController = TextEditingController();
  List<String> _observaciones = [];
  bool _isLoading = false;
  bool _hasApiKey = false;
  String _apiKeyInput = '';

  @override
  void initState() {
    super.initState();
    _checkApiKey();
  }

  Future<void> _checkApiKey() async {
    final key = await ApiKeyStorage.getKey();
    setState(() {
      _hasApiKey = key != null && key.trim().isNotEmpty;
    });
  }

  Future<void> _procesarConIA() async {
    if (_originalController.text.trim().isEmpty) return;

    if (!_hasApiKey) {
      _showApiKeyDialog();
      return;
    }

    setState(() {
      _isLoading = true;
      _observaciones = [];
      _iaController.clear();
    });

    final resultado = await AiTacticalService.pulirTexto(_originalController.text);

    setState(() => _isLoading = false);

    if (resultado != null) {
      setState(() {
        _iaController.text = resultado.textoAuditado;
        _observaciones = resultado.observacionesTacticas;
      });
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(
              'Error al procesar el texto. Verifica tu conexión o que tu API Key de Gemini sea válida.',
            ),
            backgroundColor: Theme.of(context).extension<NeuralThemeData>()?.pink ?? Colors.redAccent,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        );
      }
    }
  }

  void _showApiKeyDialog() {
    showDialog(
      context: context,
      barrierDismissible: !_isLoading,
      builder: (ctx) {
        final nt = NeuralTheme.of(context);
        return StatefulBuilder(
          builder: (_, setDialogState) {
            bool isVerifying = false;
            String errorMsg = '';

            Future<void> verifyAndSave(String key) async {
              if (key.trim().isEmpty) {
                setDialogState(() => errorMsg = 'La clave no puede estar vacía');
                return;
              }

              setDialogState(() {
                isVerifying = true;
                errorMsg = '';
              });

              final isValid = await AiTacticalService.validarToken(key);

              if (isValid) {
                await ApiKeyStorage.saveKey(key);
                await _checkApiKey();
                if (ctx.mounted) {
                  Navigator.pop(ctx);
                }
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('API Key guardada y verificada con éxito.'),
                      backgroundColor: nt.successGreen,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  );
                }
              } else {
                setDialogState(() {
                  isVerifying = false;
                  errorMsg = 'API Key inválida. Intente nuevamente.';
                });
              }
            }

            return AlertDialog(
              backgroundColor: nt.surfaceCard,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
              title: Row(
                children: [
                  Icon(Icons.key_rounded, color: nt.blueGoogle),
                  const SizedBox(width: 12),
                  const Text(
                    'Configurar Gemini API Key',
                    style: TextStyle(
                      fontFamily: 'Outfit',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Se requiere una API Key de Google Gemini para utilizar el Auditor de Texto. Sus datos se guardarán localmente de forma segura.',
                    style: TextStyle(color: nt.textSecondary, fontSize: 13, height: 1.4),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    obscureText: true,
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                    decoration: InputDecoration(
                      hintText: 'Pega tu clave API aquí...',
                      hintStyle: const TextStyle(color: Colors.white24),
                      fillColor: nt.background,
                      filled: true,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.1)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: nt.blueGoogle),
                      ),
                    ),
                    onChanged: (val) => _apiKeyInput = val,
                  ),
                  if (errorMsg.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Text(
                      errorMsg,
                      style: TextStyle(color: nt.pink, fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ],
                ],
              ),
              actions: [
                TextButton(
                  onPressed: isVerifying ? null : () => Navigator.pop(ctx),
                  child: Text('Cancelar', style: TextStyle(color: nt.textMuted)),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: nt.blueGoogle,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  ),
                  onPressed: isVerifying ? null : () => verifyAndSave(_apiKeyInput),
                  child: isVerifying
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                        )
                      : const Text('Verificar y Guardar', style: TextStyle(color: Colors.white)),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _copyToClipboard() {
    if (_iaController.text.isEmpty) return;
    Clipboard.setData(ClipboardData(text: _iaController.text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Texto corregido copiado al portapapeles.'),
        backgroundColor: Theme.of(context).extension<NeuralThemeData>()?.blueGoogle ?? Colors.blueAccent,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final nt = NeuralTheme.of(context);
    final isDesktop = MediaQuery.of(context).size.width >= 800;

    return Scaffold(
      backgroundColor: nt.background,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
          onPressed: () => context.pop(),
        ),
        title: const Text('Auditor de Texto (Perito IA)'),
        actions: [
          IconButton(
            icon: Icon(
              Icons.key_rounded,
              color: _hasApiKey ? nt.successGreen : nt.warningAmber,
            ),
            tooltip: 'Configurar API Key',
            onPressed: _showApiKeyDialog,
          ),
        ],
      ),
      body: NeuralBackgroundWrapper(
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1200),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title and description card
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: nt.surfaceCard.withValues(alpha: 0.4),
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: nt.purple.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: nt.purple.withValues(alpha: 0.3)),
                            ),
                            child: Icon(Icons.fact_check_rounded, color: nt.purple, size: 28),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Perito Documental e IA',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Outfit',
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Corrige ortografía, sintaxis y estructura tus informes en tercera persona de manera objetiva.',
                                  style: TextStyle(color: Colors.white.withValues(alpha: 0.6), fontSize: 13),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Main Panels Layout (responsive)
                    if (isDesktop)
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(child: _buildInputPanel(nt)),
                          const SizedBox(width: 24),
                          Expanded(child: _buildOutputPanel(nt)),
                        ],
                      )
                    else ...[
                      _buildInputPanel(nt),
                      const SizedBox(height: 24),
                      _buildOutputPanel(nt),
                    ],

                    const SizedBox(height: 24),

                    // Observations Panel (if populated)
                    if (_observaciones.isNotEmpty) _buildObservationsPanel(nt),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputPanel(NeuralThemeData nt) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: nt.surfaceCard.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Redacción Original / Borrador',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
              fontFamily: 'Outfit',
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _originalController,
            maxLines: 8,
            style: const TextStyle(color: Colors.white, fontSize: 14, height: 1.5),
            decoration: InputDecoration(
              hintText: 'Escribe o pega tu texto bruto aquí...\nEj: "Yo vi que el sospechoso entró corriendo a las 3 de la tarde y parecía culpable..."',
              hintStyle: const TextStyle(color: Colors.white30),
              fillColor: nt.background.withValues(alpha: 0.5),
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.06)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: nt.blueGoogle),
              ),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: nt.blueGoogle,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                shadowColor: nt.blueGoogle.withValues(alpha: 0.4),
                elevation: 8,
              ),
              onPressed: _isLoading ? null : _procesarConIA,
              child: _isLoading
                  ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.5),
                    )
                  : const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.auto_awesome_rounded, color: Colors.white, size: 20),
                        SizedBox(width: 8),
                        Text(
                          'Auditar y Corregir con IA',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOutputPanel(NeuralThemeData nt) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: nt.surfaceCard.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Texto Corregido y Auditado',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Outfit',
                ),
              ),
              if (_iaController.text.isNotEmpty)
                IconButton(
                  icon: Icon(Icons.copy_all_rounded, color: nt.blueGoogle),
                  tooltip: 'Copiar texto',
                  onPressed: _copyToClipboard,
                ),
            ],
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _iaController,
            maxLines: 8,
            readOnly: true,
            style: TextStyle(color: Colors.white.withValues(alpha: 0.95), fontSize: 14, height: 1.5),
            decoration: InputDecoration(
              hintText: 'El texto corregido en formato formal y en tercera persona aparecerá aquí...',
              hintStyle: const TextStyle(color: Colors.white24),
              fillColor: nt.background.withValues(alpha: 0.3),
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.06)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildObservationsPanel(NeuralThemeData nt) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: nt.surfaceCard.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.assignment_turned_in_rounded, color: nt.cyan, size: 20),
              const SizedBox(width: 8),
              const Text(
                'Observaciones Tácticas del Perito',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Outfit',
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ..._observaciones.map((obs) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 6.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('• ', style: TextStyle(color: nt.cyan, fontSize: 16, fontWeight: FontWeight.bold)),
                    Expanded(
                      child: Text(
                        obs,
                        style: TextStyle(color: Colors.white.withValues(alpha: 0.85), fontSize: 14, height: 1.4),
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _originalController.dispose();
    _iaController.dispose();
    super.dispose();
  }
}
