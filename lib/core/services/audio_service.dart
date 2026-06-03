import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:learn/core/services/local_storage_service.dart';

class AudioService extends ChangeNotifier {
  final AudioPlayer _player = AudioPlayer();
  final LocalStorageService _storage;
  bool _isMuted = false;

  AudioService(this._storage) {
    _isMuted = _storage.loadMuted();
  }

  bool get isMuted => _isMuted;

  void toggleMute() {
    _isMuted = !_isMuted;
    _storage.saveMuted(_isMuted);
    notifyListeners();
  }

  Future<void> playCorrectSound() async {
    if (_isMuted) return;
    try {
      await _player.play(AssetSource('audio/correct.mp3'));
    } catch (e) {
      // Ignorar errores de audio silenciosamente
    }
  }

  Future<void> playIncorrectSound() async {
    if (_isMuted) return;
    try {
      await _player.play(AssetSource('audio/incorrect.mp3'));
    } catch (e) {
      // Ignorar errores de audio
    }
  }

  void dispose() {
    _player.dispose();
  }
}
