import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:learn/core/config/neural_theme.dart';
import 'package:learn/features/miniapps/pt_exploratory_view.dart';
import 'package:learn/features/miniapps/pt_training_view.dart';
import 'package:learn/features/miniapps/pt_survival_view.dart';

class PeriodicTableScreen extends StatefulWidget {
  const PeriodicTableScreen({super.key});

  @override
  State<PeriodicTableScreen> createState() => _PeriodicTableScreenState();
}

class _PeriodicTableScreenState extends State<PeriodicTableScreen> {
  int _currentIndex = 0;

  final List<Widget> _views = [
    const PtExploratoryView(),
    const PtTrainingView(),
    const PtSurvivalView(),
  ];

  @override
  Widget build(BuildContext context) {
    final nt = NeuralTheme.of(context);

    return Scaffold(
      backgroundColor: nt.background,
      appBar: AppBar(
        backgroundColor: nt.surfaceElevated,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
          onPressed: () => context.pop(),
        ),
        title: const Text(
          'Tabla PeriÃ³dica',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: _views[_currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: nt.surfaceElevated,
        selectedItemColor: nt.blueGoogle,
        unselectedItemColor: Colors.white54,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_view_rounded),
            label: 'Explorar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center_rounded),
            label: 'Entrenar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.timer_rounded),
            label: 'Supervivencia',
          ),
        ],
      ),
    );
  }
}
