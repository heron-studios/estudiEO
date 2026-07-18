import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:learn/core/services/api_key_storage.dart';
import 'package:learn/core/services/ai_tactical_service.dart';

void main() {
  // Set up mock initial values for SharedPreferences
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  group('ApiKeyStorage Tests', () {
    test('Should save, retrieve, and clear API Key successfully', () async {
      // Initially, the key should be null
      final initialKey = await ApiKeyStorage.getKey();
      expect(initialKey, isNull);

      // Save a key
      const dummyKey = 'AIzaSyTestGemini12345';
      await ApiKeyStorage.saveKey(dummyKey);

      // Retrieve the saved key
      final savedKey = await ApiKeyStorage.getKey();
      expect(savedKey, equals(dummyKey));

      // Clear the key
      await ApiKeyStorage.clearKey();

      // Key should be null again
      final clearedKey = await ApiKeyStorage.getKey();
      expect(clearedKey, isNull);
    });
  });

  group('AuditMaestroResult Tests', () {
    test('Should parse JSON correctly', () {
      final jsonMap = {
        'texto_auditado': 'El postulante se presentó a la hora indicada.',
        'observaciones_tacticas': [
          'Se corrigió ortografía.',
          'Se cambió a tercera persona.',
        ],
      };

      final result = AuditMaestroResult.fromJson(jsonMap);

      expect(
        result.textoAuditado,
        equals('El postulante se presentó a la hora indicada.'),
      );
      expect(result.observacionesTacticas.length, equals(2));
      expect(
        result.observacionesTacticas[0],
        equals('Se corrigió ortografía.'),
      );
      expect(
        result.observacionesTacticas[1],
        equals('Se cambió a tercera persona.'),
      );
    });

    test('Should handle null/missing fields gracefully', () {
      final jsonMap = <String, dynamic>{};

      final result = AuditMaestroResult.fromJson(jsonMap);

      expect(result.textoAuditado, equals(''));
      expect(result.observacionesTacticas, isEmpty);
    });
  });

  group('AiTacticalService Tests', () {
    test(
      'validarToken should return false on invalid token or exception',
      () async {
        // Act
        final isValid = await AiTacticalService.validarToken(
          'invalid_token_xyz',
        );

        // Assert
        expect(isValid, isFalse);
      },
    );

    test('pulirTexto should return null if borrador is empty', () async {
      final result = await AiTacticalService.pulirTexto('');
      expect(result, isNull);
    });

    test('pulirTexto should return null if token is not set', () async {
      // Ensure token is not set
      await ApiKeyStorage.clearKey();

      final result = await AiTacticalService.pulirTexto('Some draft');
      expect(result, isNull);
    });
  });
}
