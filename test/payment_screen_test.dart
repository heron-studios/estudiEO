import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:learn/features/payment/presentation/payment_screen.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('PaymentScreen Widget Tests', () {
    testWidgets('Renders all core elements in desktop layout',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1280, 900);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        const MaterialApp(
          home: PaymentScreen(),
        ),
      );

      await tester.pump();

      // Check title and segmented control tabs
      expect(find.text('EDUPOL PRO • Activación'), findsOneWidget);
      expect(find.text('Pago & QR'), findsOneWidget);
      expect(find.text('Beneficios PRO'), findsOneWidget);

      // Check price
      expect(find.text('S/ 30.00'), findsOneWidget);
      expect(find.textContaining('Un solo pago de por vida'), findsOneWidget);

      // Check Yape details
      expect(find.text('YAPE OFICIAL'), findsOneWidget);
      expect(find.text('955 285 763'), findsOneWidget);
      expect(find.text('Copiar'), findsOneWidget);

      // Check WhatsApp CTA button
      expect(find.text('Solicitar acceso PRO'), findsOneWidget);

      // Switch to Beneficios PRO tab
      await tester.tap(find.text('Beneficios PRO'));
      await tester.pumpAndSettle();

      // Check benefits in Tab 1
      expect(find.text('¿Qué incluye tu Acceso PRO de por vida?'), findsOneWidget);
      expect(find.text('Temarios Oficiales PNP 2026 Completos'), findsOneWidget);
      expect(find.text('Simulacros Oficiales Cronometrados'), findsOneWidget);
      expect(find.text('Radar Predictivo de Riesgo'), findsOneWidget);
      expect(find.text('Ver QR de Pago (S/ 30.00)'), findsOneWidget);

      // Switch back to Pago & QR via button
      await tester.tap(find.text('Ver QR de Pago (S/ 30.00)'));
      await tester.pumpAndSettle();

      expect(find.text('Solicitar acceso PRO'), findsOneWidget);
    });

    testWidgets('Renders all core elements in mobile layout without overflow',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(390, 844);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        const MaterialApp(
          home: PaymentScreen(),
        ),
      );

      await tester.pump();

      // Verify essential mobile components in Tab 0
      expect(find.text('S/ 30.00'), findsOneWidget);
      expect(find.text('YAPE OFICIAL'), findsOneWidget);
      expect(find.text('955 285 763'), findsOneWidget);
      expect(find.text('Solicitar acceso PRO'), findsOneWidget);
    });

    testWidgets('Tap Copiar number copies to clipboard and displays feedback',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(800, 1000);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      // Mock clipboard
      String? clipboardData;
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(SystemChannels.platform, (MethodCall methodCall) async {
        if (methodCall.method == 'Clipboard.setData') {
          final args = methodCall.arguments as Map;
          clipboardData = args['text'] as String?;
          return null;
        }
        return null;
      });

      await tester.pumpWidget(
        const MaterialApp(
          home: PaymentScreen(),
        ),
      );

      await tester.pump();

      final copyButton = find.text('Copiar');
      expect(copyButton, findsOneWidget);

      await tester.tap(copyButton);
      await tester.pump();

      expect(clipboardData, '955285763');
      expect(find.text('¡Copiado!'), findsOneWidget);

      // Advance clock past timer so teardown succeeds cleanly
      await tester.pump(const Duration(seconds: 4));
    });
  });
}
