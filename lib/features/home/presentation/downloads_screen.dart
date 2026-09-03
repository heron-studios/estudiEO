import 'package:flutter/material.dart';
import 'package:learn/core/config/neural_theme.dart';
import 'package:learn/core/widgets/animated_grid_bg.dart';
import 'downloads_dialog.dart';

export 'downloads_dialog.dart';

/// Pantalla envolvente para la ruta directa `/downloads` que muestra el `DownloadsDialog` centrado.
class DownloadsScreen extends StatelessWidget {
  final bool showBackButton;

  const DownloadsScreen({
    super.key,
    this.showBackButton = true,
  });

  @override
  Widget build(BuildContext context) {
    final nt = NeuralTheme.of(context);

    return Scaffold(
      backgroundColor: nt.background,
      body: const AnimatedGridBackground(
        child: SafeArea(
          child: Center(
            child: DownloadsDialog(),
          ),
        ),
      ),
    );
  }
}
