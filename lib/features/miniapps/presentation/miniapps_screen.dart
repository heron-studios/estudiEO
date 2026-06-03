import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:learn/core/config/neural_theme.dart';
import 'package:learn/core/widgets/neural_background_wrapper.dart';
import 'package:learn/core/widgets/glass_card_widget.dart';

class MiniAppsScreen extends StatelessWidget {
  const MiniAppsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final nt = NeuralTheme.of(context);

    return Scaffold(
      backgroundColor: nt.background,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded,
              color: Colors.white),
          onPressed: () => context.pop(),
        ),
        title: const Text(
          'Mini Apps',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: NeuralBackgroundWrapper(
        child: SafeArea(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Herramientas Interactivas',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.9),
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Potencia tu memoria y agilidad mental con estas aplicaciones rápidas.',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.6),
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 24),
                 Expanded(
                  child: GridView.count(
                    crossAxisCount:
                        MediaQuery.of(context).size.width > 1100
                            ? 3
                            : (MediaQuery.of(context).size.width > 650 ? 2 : 1),
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio:
                        MediaQuery.of(context).size.width > 650 ? 1.5 : 2.5,
                    children: [
                      // ── Tabla Periódica ────────────────────────────────
                      HoverGlassCard(
                        borderRadius: BorderRadius.circular(20),
                        onTap: () =>
                            context.push('/miniapps/periodic-table'),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Row(
                            children: [
                              Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  color: nt.blueGoogle
                                      .withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.science_rounded,
                                    color: nt.blueGoogle,
                                    size: 32,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      'Tabla Periódica',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Modo exploratorio, entrenamiento dual y supervivencia.',
                                      style: TextStyle(
                                        color: Colors.white
                                            .withValues(alpha: 0.6),
                                        fontSize: 13,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                              const Icon(
                                Icons.chevron_right_rounded,
                                color: Colors.white30,
                              ),
                            ],
                          ),
                        ),
                      ),

                      // ── Silogismos ────────────────────────────────────
                      HoverGlassCard(
                        borderRadius: BorderRadius.circular(20),
                        onTap: () =>
                            context.push('/miniapps/silogismos'),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Row(
                            children: [
                              Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF14B8A6)
                                      .withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: const Center(
                                  child: Icon(
                                    Icons.account_tree_rounded,
                                    color: Color(0xFF14B8A6),
                                    size: 32,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        const Text(
                                          'Silogismos',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Container(
                                          padding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 6,
                                                  vertical: 2),
                                          decoration: BoxDecoration(
                                            color: const Color(0xFF14B8A6)
                                                .withValues(alpha: 0.2),
                                            borderRadius:
                                                BorderRadius.circular(6),
                                            border: Border.all(
                                              color: const Color(0xFF14B8A6)
                                                  .withValues(alpha: 0.5),
                                            ),
                                          ),
                                          child: const Text(
                                            'MINIJUEGO',
                                            style: TextStyle(
                                              color: Color(0xFF14B8A6),
                                              fontSize: 8,
                                              fontWeight: FontWeight.w900,
                                              letterSpacing: 0.5,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Lógica deductiva e inferencia. Repaso de razonamiento verbal.',
                                      style: TextStyle(
                                        color: Colors.white
                                            .withValues(alpha: 0.6),
                                        fontSize: 13,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                              const Icon(
                                Icons.chevron_right_rounded,
                                color: Colors.white30,
                              ),
                            ],
                          ),
                        ),
                      ),

                      // ── ANP Master ─────────────────────────────────────
                      HoverGlassCard(
                        borderRadius: BorderRadius.circular(20),
                        onTap: () =>
                            context.push('/miniapps/anp-master'),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Row(
                            children: [
                              Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  color: Colors.greenAccent
                                      .withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: const Center(
                                  child: Icon(
                                    Icons.map_rounded,
                                    color: Colors.greenAccent,
                                    size: 32,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        const Text(
                                          'ANP Master',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Container(
                                          padding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 6,
                                                  vertical: 2),
                                          decoration: BoxDecoration(
                                            color: Colors.greenAccent
                                                .withValues(alpha: 0.2),
                                            borderRadius:
                                                BorderRadius.circular(6),
                                            border: Border.all(
                                              color: Colors.greenAccent
                                                  .withValues(alpha: 0.5),
                                            ),
                                          ),
                                          child: const Text(
                                            'BIODIVERSIDAD',
                                            style: TextStyle(
                                              color: Colors.greenAccent,
                                              fontSize: 8,
                                              fontWeight: FontWeight.w900,
                                              letterSpacing: 0.5,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Áreas Naturales Protegidas del Perú. Repaso visual activo y mapas.',
                                      style: TextStyle(
                                        color: Colors.white
                                            .withValues(alpha: 0.6),
                                        fontSize: 13,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                              const Icon(
                                Icons.chevron_right_rounded,
                                color: Colors.white30,
                              ),
                            ],
                          ),
                        ),
                      ),
                      // ── Productos Notables ─────────────────────────────
                      HoverGlassCard(
                        borderRadius: BorderRadius.circular(20),
                        onTap: () =>
                            context.push('/miniapps/productos-notables'),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Row(
                            children: [
                              Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  color: Colors.orangeAccent
                                      .withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: const Center(
                                  child: Icon(
                                    Icons.calculate_rounded,
                                    color: Colors.orangeAccent,
                                    size: 32,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        const Text(
                                          'Prod. Notables',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Container(
                                          padding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 6,
                                                  vertical: 2),
                                          decoration: BoxDecoration(
                                            color: Colors.orangeAccent
                                                .withValues(alpha: 0.2),
                                            borderRadius:
                                                BorderRadius.circular(6),
                                            border: Border.all(
                                              color: Colors.orangeAccent
                                                  .withValues(alpha: 0.5),
                                            ),
                                          ),
                                          child: const Text(
                                            'MATEMÁTICA',
                                            style: TextStyle(
                                              color: Colors.orangeAccent,
                                              fontSize: 8,
                                              fontWeight: FontWeight.w900,
                                              letterSpacing: 0.5,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Aprende de forma interactiva las fórmulas matemáticas principales.',
                                      style: TextStyle(
                                        color: Colors.white
                                            .withValues(alpha: 0.6),
                                        fontSize: 13,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                              const Icon(
                                Icons.chevron_right_rounded,
                                color: Colors.white30,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
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
