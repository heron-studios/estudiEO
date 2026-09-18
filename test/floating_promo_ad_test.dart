import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:learn/core/config/app_config.dart';
import 'package:learn/core/widgets/floating_promo_ad.dart';

void main() {
  test('AppConfig has correct updated APK download URL', () {
    expect(
      AppConfig.androidApkDownloadUrl,
      'https://www.mediafire.com/file/zvsyh4o6wl08yn8/edupol.apk/file',
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

      // Verify CTA buttons
      expect(find.text('Instalar desde Play Store'), findsOneWidget);
      expect(find.text('Descargar APK'), findsOneWidget);

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
      expect(find.text('Instalar desde Play Store'), findsOneWidget);
      expect(find.text('Descargar APK Directa'), findsOneWidget);

      // Tap close button
      final closeButton = find.byIcon(Icons.close_rounded);
      expect(closeButton, findsOneWidget);
      await tester.tap(closeButton);
      await tester.pumpAndSettle();

      // Now it should be in collapsed pill state
      expect(find.text('Instalar App Android'), findsOneWidget);
      expect(find.text('¡Estudia como un verdadero Oficial!'), findsNothing);

      // Tap pill to re-expand
      await tester.tap(find.text('Instalar App Android'));
      await tester.pumpAndSettle();

      // Expanded again
      expect(find.text('¡Estudia como un verdadero Oficial!'), findsOneWidget);
    });
  });
}
