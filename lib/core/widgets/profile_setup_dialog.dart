import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:learn/core/config/neural_design_system.dart';
import 'package:learn/core/services/local_storage_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileSetupDialog extends StatefulWidget {
  const ProfileSetupDialog({super.key});

  static Future<void> showIfNeeded(BuildContext context) async {
    final storage = context.read<LocalStorageService>();
    final name = storage.loadUserName();
    final school = storage.loadTargetSchool();

    // If name is empty or default, or school is not one of the valid ones
    if (name.trim().isEmpty || name.trim().toLowerCase() == 'aspirante' || 
        (school != 'EO PNP' && school != 'EETSPN')) {
      await showDialog(
        context: context,
        barrierDismissible: false,
        barrierColor: Colors.black87,
        builder: (context) => const PopScope(
          canPop: false, // Prevent back button
          child: ProfileSetupDialog(),
        ),
      );
    }
  }

  @override
  State<ProfileSetupDialog> createState() => _ProfileSetupDialogState();
}

class _ProfileSetupDialogState extends State<ProfileSetupDialog> {
  late TextEditingController _nameController;
  String _selectedSchool = 'EO PNP'; // Default starting point for selection
  bool _isLoading = false;
  String _errorText = '';

  @override
  void initState() {
    super.initState();
    final storage = context.read<LocalStorageService>();
    final googleName = FirebaseAuth.instance.currentUser?.displayName;
    String currentName = storage.loadUserName();
    if (currentName == 'Aspirante' || currentName.trim().isEmpty) {
      currentName = (googleName != null && googleName.trim().isNotEmpty) 
          ? googleName 
          : 'Usuario PNP';
    }

    _nameController = TextEditingController(text: currentName);
    final currentSchool = storage.loadTargetSchool();
    if (currentSchool == 'EO PNP' || currentSchool == 'EETSPN') {
      _selectedSchool = currentSchool;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _saveProfile() async {
    final name = _nameController.text.trim();
    if (name.isEmpty) {
      setState(() => _errorText = 'Por favor, ingresa tu nombre o alias');
      return;
    }
    if (name.length < 3) {
      setState(() => _errorText = 'El nombre debe tener al menos 3 caracteres');
      return;
    }

    setState(() {
      _isLoading = true;
      _errorText = '';
    });

    try {
      final storage = context.read<LocalStorageService>();
      await storage.saveUserName(name);
      await storage.saveTargetSchool(_selectedSchool);

      if (mounted) {
        Navigator.of(context).pop(); // Close dialog
      }
    } catch (e) {
      setState(() {
        _errorText = 'Error al guardar. Intenta de nuevo.';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 450),
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: NeuralDesignSystem.surfaceCard,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: NeuralDesignSystem.blueGoogle.withValues(alpha: 0.3),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: NeuralDesignSystem.blueGoogle.withValues(alpha: 0.15),
              blurRadius: 30,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(
              Icons.account_circle_rounded,
              color: NeuralDesignSystem.blueGoogle,
              size: 56,
            ),
            const SizedBox(height: 16),
            const Text(
              '¡Bienvenido a EDUPOL!',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontFamily: 'Outfit',
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Antes de empezar o ver el leaderboard, necesitamos conocerte un poco mejor para personalizar tu experiencia.',
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.8),
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            const Text(
              'Tu nombre o alias',
              style: TextStyle(color: Colors.white70, fontSize: 13, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _nameController,
              readOnly: true, // No editable por petición
              style: TextStyle(color: Colors.white.withValues(alpha: 0.6)),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.black12, // Más oscuro para indicar read-only
                hintText: 'Ej. Juan Pérez',
                hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.3)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Escuela a la que postulas',
              style: TextStyle(color: Colors.white70, fontSize: 13, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              initialValue: _selectedSchool,
              dropdownColor: NeuralDesignSystem.surfaceCard,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.black26,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              ),
              items: const [
                DropdownMenuItem(value: 'EO PNP', child: Text('EO PNP')),
                DropdownMenuItem(value: 'EETSPN', child: Text('EETSPN')),
              ],
              onChanged: (val) {
                if (val != null) setState(() => _selectedSchool = val);
              },
            ),
            if (_errorText.isNotEmpty) ...[
              const SizedBox(height: 16),
              Text(
                _errorText,
                style: const TextStyle(color: NeuralDesignSystem.pink, fontSize: 13),
                textAlign: TextAlign.center,
              ),
            ],
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: _isLoading ? null : _saveProfile,
              style: ElevatedButton.styleFrom(
                backgroundColor: NeuralDesignSystem.blueGoogle,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              child: _isLoading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                    )
                  : const Text(
                      'Guardar y Continuar',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
