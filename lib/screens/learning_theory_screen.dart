import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:learn/models/learning_level.dart';
import 'package:learn/providers/learning_provider.dart';
import 'package:learn/providers/subject_provider.dart';

/// Pantalla 1 del Modo Aprendizaje Guiado — Fase Absorción (Teoría).
///
/// Muestra el contenido teórico del nivel actual con un diseño de lectura
/// premium. El contenido real se marcará con un placeholder hasta que sea
/// rellenado por el equipo de contenido.
class LearningTheoryScreen extends StatefulWidget {
  final String topicId;
  final Dificultad nivel;

  const LearningTheoryScreen({
    super.key,
    required this.topicId,
    required this.nivel,
  });

  @override
  State<LearningTheoryScreen> createState() => _LearningTheoryScreenState();
}

class _LearningTheoryScreenState extends State<LearningTheoryScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _buttonController;
  late Animation<double> _buttonScale;

  @override
  void initState() {
    super.initState();
    _buttonController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..repeat(reverse: true);
    _buttonScale = Tween<double>(begin: 1.0, end: 1.04).animate(
      CurvedAnimation(parent: _buttonController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _buttonController.dispose();
    super.dispose();
  }

  void _startPractice(BuildContext context) {
    final learningProvider = context.read<LearningProvider>();

    // Si hay sesión pendiente guardada, retomar; si no, crear nueva
    final hasPending =
        learningProvider.hasPendingSession(widget.topicId, widget.nivel);

    if (hasPending) {
      learningProvider.resumeSession(widget.topicId, widget.nivel);
    } else {
      learningProvider.startSession(widget.topicId, widget.nivel);
    }

    Navigator.pushReplacementNamed(
      context,
      '/learning-quiz',
      arguments: {
        'topicId': widget.topicId,
        'nivel': widget.nivel,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final subjectProvider = context.read<SubjectProvider>();
    final topic = subjectProvider.getTopic(widget.topicId);
    final topicName = topic?.name ?? 'Tema';

    return Scaffold(
      backgroundColor: const Color(0xFF0A0F1E),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // ─── SliverAppBar premium ──────────────────────────────────────
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            backgroundColor: const Color(0xFF0A0F1E),
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new,
                  color: Colors.white, size: 20),
              onPressed: () => Navigator.pop(context),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: _TheoryHeader(
                topicName: topicName,
                nivel: widget.nivel,
              ),
            ),
          ),

          // ─── Contenido teórico ─────────────────────────────────────────
          SliverToBoxAdapter(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 720),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 140),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Indicador de nivel en la ruta
                      _LevelBreadcrumb(nivel: widget.nivel),
                      const SizedBox(height: 24),

                      // Sección principal de teoría
                      _TheorySection(
                        title: '📖 Contenido de Nivel ${widget.nivel.displayName}',
                        content: subjectProvider.getTheoryByTopicAndLevel(widget.topicId, widget.nivel) ?? 
                            'Aún no hay contenido teórico registrado para este nivel. Por favor, contacta al administrador.',
                      ),
                      const SizedBox(height: 20),

                      // Recuerda / Tip
                      _TipCard(nivel: widget.nivel),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),

      // ─── Botón flotante de CTA ─────────────────────────────────────────
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: _StartPracticeButton(
        buttonScale: _buttonScale,
        nivel: widget.nivel,
        onTap: () => _startPractice(context),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Widgets internos
// ─────────────────────────────────────────────────────────────────────────────

class _TheoryHeader extends StatelessWidget {
  final String topicName;
  final Dificultad nivel;

  const _TheoryHeader({required this.topicName, required this.nivel});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            nivel.color.withValues(alpha: 0.25),
            const Color(0xFF0A0F1E),
          ],
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(72, 16, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                    decoration: BoxDecoration(
                      color: nivel.color.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                          color: nivel.color.withValues(alpha: 0.4), width: 1),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(nivel.emoji, style: const TextStyle(fontSize: 14)),
                        const SizedBox(width: 6),
                        Text(
                          'Nivel ${nivel.displayName}',
                          style: TextStyle(
                            color: nivel.color,
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  const Icon(Icons.menu_book_rounded,
                      color: Colors.white38, size: 28),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                topicName,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  height: 1.3,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                'Lee con atención antes de practicar',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.5),
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LevelBreadcrumb extends StatelessWidget {
  final Dificultad nivel;

  const _LevelBreadcrumb({required this.nivel});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: Dificultad.values.map((d) {
        final isActive = d == nivel;
        final isPast = d.index2 < nivel.index2;
        return Expanded(
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      height: 4,
                      decoration: BoxDecoration(
                        color: isPast
                            ? d.color
                            : isActive
                                ? nivel.color
                                : const Color(0xFF1E293B),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      d.displayName,
                      style: TextStyle(
                        color: isActive
                            ? nivel.color
                            : isPast
                                ? Colors.white38
                                : Colors.white24,
                        fontSize: 11,
                        fontWeight: isActive
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
              if (d != Dificultad.extremo) const SizedBox(width: 4),
            ],
          ),
        );
      }).toList(),
    );
  }
}

class _TheorySection extends StatelessWidget {
  final String title;
  final String content;

  const _TheorySection({required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF111827),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF1F2937), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.3,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            content,
            style: const TextStyle(
              color: Color(0xFFCBD5E1),
              fontSize: 15,
              height: 1.75,
              letterSpacing: 0.1,
            ),
          ),
        ],
      ),
    );
  }
}

class _TipCard extends StatelessWidget {
  final Dificultad nivel;

  const _TipCard({required this.nivel});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            nivel.color.withValues(alpha: 0.12),
            nivel.bgColor.withValues(alpha: 0.6),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
            color: nivel.color.withValues(alpha: 0.3), width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('✨', style: TextStyle(fontSize: 22)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Recuerda',
                  style: TextStyle(
                    color: nivel.color,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Para pasar al siguiente nivel necesitas responder correctamente 10 preguntas. Si fallas, la pregunta regresa al final de la cola para que la practiques de nuevo. ¡La constancia es la clave!',
                  style: TextStyle(
                    color: Color(0xFFCBD5E1),
                    fontSize: 14,
                    height: 1.6,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StartPracticeButton extends StatelessWidget {
  final Animation<double> buttonScale;
  final Dificultad nivel;
  final VoidCallback onTap;

  const _StartPracticeButton({
    required this.buttonScale,
    required this.nivel,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
      decoration: BoxDecoration(
        color: const Color(0xFF0A0F1E),
        border: const Border(
          top: BorderSide(color: Color(0xFF1F2937), width: 1),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.4),
            blurRadius: 20,
            offset: const Offset(0, -8),
          ),
        ],
      ),
      child: ScaleTransition(
        scale: buttonScale,
        child: SizedBox(
          width: double.infinity,
          height: 56,
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  nivel.color,
                  nivel.color.withValues(alpha: 0.75),
                ],
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: nivel.color.withValues(alpha: 0.4),
                  blurRadius: 20,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onTap,
                borderRadius: BorderRadius.circular(16),
                child: const Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '¡Entendido, a practicar!',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.3,
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.arrow_forward_rounded,
                          color: Colors.white, size: 22),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
