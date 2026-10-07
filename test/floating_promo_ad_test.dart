import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:learn/core/config/app_config.dart';
import 'package:learn/core/widgets/floating_promo_ad.dart';

void main() {
  test('AppConfig has correct Google Play Store URL', () {
    expect(
      AppConfig.playStoreUrl,
      'https://play.google.com/store/apps/details?id=com.edupol.radar',
    );
  });

  group('FloatingPromoAd Widget Tests', () {
    testWidgets('Renders in desktop mode with split layout and buttons',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1280, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Stack(
              children: [
                FloatingPromoAd(),
              ],
            ),
          ),
        ),
      );

      await tester.pump();

      // Verify header and titles
      expect(find.text('EDUPOL ANDROID OFICIAL'), findsOneWidget);
      expect(find.text('¡Asegura tu Ingreso a la Policía Nacional!'), findsOneWidget);

      // Verify Google Play button and no APK button
      expect(find.text('Google Play'), findsOneWidget);
      expect(find.text('DISPONIBLE AHORA EN'), findsOneWidget);
      expect(find.text('Descargar APK'), findsNothing);

      // Verify pillars of value
      expect(find.text('Modo Práctica 100% Offline'), findsOneWidget);
      expect(find.text('Máxima Fluidez y Cero Lag'), findsOneWidget);
    });

    testWidgets('Renders in mobile mode without overflow and collapses/expands',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(390, 844);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Stack(
              children: [
                FloatingPromoAd(),
              ],
            ),
          ),
        ),
      );

      await tester.pump();

      // In mobile, verify header
      expect(find.text('EDUPOL OFICIAL ANDROID'), findsOneWidget);
      expect(find.text('¡Estudia como un verdadero Oficial!'), findsOneWidget);
      expect(find.text('Google Play'), findsOneWidget);
      expect(find.text('Descargar APK Directa'), findsNothing);

      // Tap close button
      final closeButton = find.byIcon(Icons.close_rounded);
      expect(closeButton, findsOneWidget);
      await tester.tap(closeButton);
      await tester.pumpAndSettle();

      // Now it should be in collapsed pill state
      expect(find.text('Descargar en Google Play'), findsOneWidget);
      expect(find.text('¡Estudia como un verdadero Oficial!'), findsNothing);

      // Tap pill to re-expand
      await tester.tap(find.text('Descargar en Google Play'));
      await tester.pumpAndSettle();

      // Expanded again
      expect(find.text('¡Estudia como un verdadero Oficial!'), findsOneWidget);
    });
  });
}
