// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:learn/features/payment/presentation/payment_screen.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:url_launcher_platform_interface/url_launcher_platform_interface.dart';

/// Lightweight platform mock for [UrlLauncherPlatform] using [MockPlatformInterfaceMixin].
class MockUrlLauncherPlatform extends Fake
    with MockPlatformInterfaceMixin
    implements UrlLauncherPlatform {
  String? lastLaunchedUrl;
  LaunchOptions? lastOptions;
  bool returnSuccess = true;
  bool throwOnLaunch = false;

  @override
  Future<bool> launchUrl(String url, LaunchOptions options) async {
    lastLaunchedUrl = url;
    lastOptions = options;
    if (throwOnLaunch) {
      throw PlatformException(
        code: 'ACTIVITY_NOT_FOUND',
        message: 'No Activity found to handle Intent',
      );
    }
    return returnSuccess;
  }

  @override
  Future<bool> canLaunch(String url) async => true;
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockUrlLauncherPlatform mockUrlLauncher;
  late UrlLauncherPlatform originalUrlLauncher;
  String? clipboardData;

  void setupMockClipboard() {
    clipboardData = null;
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(SystemChannels.platform, (MethodCall methodCall) async {
      if (methodCall.method == 'Clipboard.setData') {
        final args = methodCall.arguments as Map;
        clipboardData = args['text'] as String?;
        return null;
      }
      return null;
    });
  }

  void tearDownMockClipboard() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(SystemChannels.platform, null);
  }

  setUp(() {
    mockUrlLauncher = MockUrlLauncherPlatform();
    originalUrlLauncher = UrlLauncherPlatform.instance;
    UrlLauncherPlatform.instance = mockUrlLauncher;
  });

  tearDown(() {
    UrlLauncherPlatform.instance = originalUrlLauncher;
    tearDownMockClipboard();
  });

  // ───────────────────────────────────────────────────────────────────────────
  // GROUP 1: Initial Render & Default State (AC3, R1)
  // ───────────────────────────────────────────────────────────────────────────
  group('Group 1: Initial Render & Default State (AC3, R1)', () {
    testWidgets(
      '1.1 Initial render displays header, segmented control, and all 3 plans with badges',
      (WidgetTester tester) async {
        tester.view.physicalSize = const Size(390, 844);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(tester.view.resetPhysicalSize);

        await tester.pumpWidget(
          const MaterialApp(
            home: PaymentScreen(),
          ),
        );
        await tester.pumpAndSettle();

        // Top bar header & segmented control tabs
        expect(find.text('EDUPOL PRO • Activación'), findsOneWidget);
        expect(find.text('Pago & QR'), findsOneWidget);
        expect(find.text('Beneficios PRO'), findsOneWidget);

        // Verify presence of all 3 plans
        expect(find.textContaining('Plan 1 Mes'), findsAtLeastNWidgets(1));
        expect(find.textContaining('Plan 3 Meses'), findsAtLeastNWidgets(1));
        expect(find.textContaining('Plan Hasta el Examen'), findsAtLeastNWidgets(1));

        // Badges / distinguishing subtitles for each plan
        expect(
          find.byWidgetPredicate(
            (w) =>
                w is Text &&
                (w.data?.contains('INICIAL') == true ||
                    w.data?.contains('Para probar') == true),
          ),
          findsAtLeastNWidgets(1),
          reason: 'Plan 1 Mes badge should indicate entry/trial tier',
        );
        expect(
          find.byWidgetPredicate(
            (w) =>
                w is Text &&
                (w.data?.contains('MÁS ELEGIDO') == true ||
                    w.data?.contains('Recomendado') == true ||
                    w.data?.contains('Ahorras 33%') == true),
          ),
          findsAtLeastNWidgets(1),
          reason: 'Plan 3 Meses badge should indicate hero/recommended tier',
        );
        expect(
          find.byWidgetPredicate(
            (w) =>
                w is Text &&
                (w.data?.contains('TOTAL') == true ||
                    w.data?.contains('Pago único') == true),
          ),
          findsAtLeastNWidgets(1),
          reason: 'Plan Hasta el Examen badge should indicate total/unlimited tier',
        );

        expect(tester.takeException(), isNull);
      },
    );

    testWidgets(
      '1.2 Default selected plan is Plan 3 Meses (S/ 30.00) with Monto: S/ 30',
      (WidgetTester tester) async {
        tester.view.physicalSize = const Size(390, 844);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(tester.view.resetPhysicalSize);

        await tester.pumpWidget(
          const MaterialApp(
            home: PaymentScreen(),
          ),
        );
        await tester.pumpAndSettle();

        // Price indicator shows S/ 30 or S/ 30.00
        expect(
          find.byWidgetPredicate(
            (w) => w is Text && (w.data == 'S/ 30.00' || w.data == 'S/ 30'),
          ),
          findsAtLeastNWidgets(1),
        );

        // Yape card header displays Monto: S/ 30
        expect(find.text('Monto: S/ 30'), findsOneWidget);

        // WhatsApp CTA button present
        expect(find.text('Solicitar acceso PRO'), findsOneWidget);
      },
    );
  });

  // ───────────────────────────────────────────────────────────────────────────
  // GROUP 2: Plan Selection Interactivity & Dynamic UI Updates (R1, R2, AC4)
  // ───────────────────────────────────────────────────────────────────────────
  group('Group 2: Plan Selection Interactivity & Dynamic UI Updates (R1, R2, AC4)', () {
    testWidgets(
      '2.1 Tapping Plan 1 Mes dynamically updates price and Yape amount badge to S/ 15',
      (WidgetTester tester) async {
        tester.view.physicalSize = const Size(390, 844);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(tester.view.resetPhysicalSize);

        await tester.pumpWidget(
          const MaterialApp(
            home: PaymentScreen(),
          ),
        );
        await tester.pumpAndSettle();

        final plan1Finder = find.textContaining('Plan 1 Mes');
        expect(plan1Finder, findsAtLeastNWidgets(1));
        await tester.tap(plan1Finder.first);
        await tester.pumpAndSettle();

        // Yape header updates dynamically
        expect(find.text('Monto: S/ 15'), findsOneWidget);

        // Price display reflects S/ 15
        expect(
          find.byWidgetPredicate(
            (w) => w is Text && (w.data == 'S/ 15.00' || w.data == 'S/ 15'),
          ),
          findsAtLeastNWidgets(1),
        );

        expect(tester.takeException(), isNull);
      },
    );

    testWidgets(
      '2.2 Tapping Plan Hasta el Examen dynamically updates price and Yape amount badge to S/ 50',
      (WidgetTester tester) async {
        tester.view.physicalSize = const Size(390, 844);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(tester.view.resetPhysicalSize);

        await tester.pumpWidget(
          const MaterialApp(
            home: PaymentScreen(),
          ),
        );
        await tester.pumpAndSettle();

        final untilExamFinder = find.textContaining('Plan Hasta el Examen');
        expect(untilExamFinder, findsAtLeastNWidgets(1));
        await tester.tap(untilExamFinder.first);
        await tester.pumpAndSettle();

        // Yape header updates dynamically
        expect(find.text('Monto: S/ 50'), findsOneWidget);

        // Price display reflects S/ 50
        expect(
          find.byWidgetPredicate(
            (w) => w is Text && (w.data == 'S/ 50.00' || w.data == 'S/ 50'),
          ),
          findsAtLeastNWidgets(1),
        );

        expect(tester.takeException(), isNull);
      },
    );

    testWidgets(
      '2.3 Switching through all 3 plans in sequence updates UI dynamically without jitter',
      (WidgetTester tester) async {
        tester.view.physicalSize = const Size(390, 844);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(tester.view.resetPhysicalSize);

        await tester.pumpWidget(
          const MaterialApp(
            home: PaymentScreen(),
          ),
        );
        await tester.pumpAndSettle();

        // Default state: S/ 30
        expect(find.text('Monto: S/ 30'), findsOneWidget);

        // 1. Switch to Plan 1 Mes
        await tester.tap(find.textContaining('Plan 1 Mes').first);
        await tester.pumpAndSettle();
        expect(find.text('Monto: S/ 15'), findsOneWidget);
        expect(tester.takeException(), isNull);

        // 2. Switch to Plan Hasta el Examen
        await tester.tap(find.textContaining('Plan Hasta el Examen').first);
        await tester.pumpAndSettle();
        expect(find.text('Monto: S/ 50'), findsOneWidget);
        expect(tester.takeException(), isNull);

        // 3. Switch back to Plan 3 Meses
        await tester.tap(find.textContaining('Plan 3 Meses').first);
        await tester.pumpAndSettle();
        expect(find.text('Monto: S/ 30'), findsOneWidget);
        expect(tester.takeException(), isNull);
      },
    );
  });

  // ───────────────────────────────────────────────────────────────────────────
  // GROUP 3: Clipboard Copy & Visual Feedback (R2, AC6)
  // ───────────────────────────────────────────────────────────────────────────
  group('Group 3: Clipboard Copy & Visual Feedback (R2, AC6)', () {
    testWidgets(
      '3.1 Tapping Copiar button in phone pill copies 955285763 and shows SnackBar',
      (WidgetTester tester) async {
        tester.view.physicalSize = const Size(390, 844);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(tester.view.resetPhysicalSize);

        setupMockClipboard();

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
        expect(find.byType(SnackBar), findsOneWidget);
        expect(find.textContaining('955 285 763'), findsOneWidget);

        // Timer reverts button text back to Copiar
        await tester.pump(const Duration(seconds: 4));
        expect(find.text('Copiar'), findsOneWidget);
      },
    );

    testWidgets(
      '3.2 Tapping phone number text copies 955285763 to clipboard',
      (WidgetTester tester) async {
        tester.view.physicalSize = const Size(390, 844);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(tester.view.resetPhysicalSize);

        setupMockClipboard();

        await tester.pumpWidget(
          const MaterialApp(
            home: PaymentScreen(),
          ),
        );
        await tester.pump();

        final phoneText = find.text('955 285 763');
        expect(phoneText, findsOneWidget);

        await tester.tap(phoneText);
        await tester.pump();

        expect(clipboardData, '955285763');
        expect(find.byType(SnackBar), findsOneWidget);
        expect(find.textContaining('955 285 763'), findsOneWidget);

        await tester.pump(const Duration(seconds: 4));
      },
    );

    testWidgets(
      '3.3 Tapping QR code image copies 955285763 to clipboard and displays SnackBar',
      (WidgetTester tester) async {
        tester.view.physicalSize = const Size(390, 844);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(tester.view.resetPhysicalSize);

        setupMockClipboard();

        await tester.pumpWidget(
          const MaterialApp(
            home: PaymentScreen(),
          ),
        );
        await tester.pump();

        final qrImageFinder = find.byType(Image);
        expect(qrImageFinder, findsOneWidget);

        await tester.tap(qrImageFinder);
        await tester.pump();

        expect(clipboardData, '955285763');
        expect(find.byType(SnackBar), findsOneWidget);
        expect(find.textContaining('955 285 763'), findsOneWidget);

        await tester.pump(const Duration(seconds: 4));
      },
    );
  });

  // ───────────────────────────────────────────────────────────────────────────
  // GROUP 4: WhatsApp Launching & Dynamic Message Construction (R3, AC5)
  // ───────────────────────────────────────────────────────────────────────────
  group('Group 4: WhatsApp Launching & Dynamic Message Construction (R3, AC5)', () {
    testWidgets(
      '4.1 Tapping WhatsApp button with default Plan 3 Meses launches wa.me with correct encoded message',
      (WidgetTester tester) async {
        tester.view.physicalSize = const Size(390, 844);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(tester.view.resetPhysicalSize);

        await tester.pumpWidget(
          const MaterialApp(
            home: PaymentScreen(),
          ),
        );
        await tester.pumpAndSettle();

        final ctaFinder = find.text('Solicitar acceso PRO');
        expect(ctaFinder, findsOneWidget);
        await tester.tap(ctaFinder);
        await tester.pumpAndSettle();

        expect(mockUrlLauncher.lastLaunchedUrl, isNotNull);
        final uri = Uri.parse(mockUrlLauncher.lastLaunchedUrl!);
        expect(uri.host, anyOf(equals('wa.me'), equals('api.whatsapp.com')));
        expect(mockUrlLauncher.lastLaunchedUrl, contains('51955285763'));

        final text = uri.queryParameters['text'] ?? '';
        expect(text, contains('Plan 3 Meses'));
        expect(text, anyOf(contains('S/ 30.00'), contains('S/ 30')));
        expect(text, contains('comprobante de pago'));
      },
    );

    testWidgets(
      '4.2 Tapping WhatsApp button after selecting Plan 1 Mes launches wa.me with Plan 1 Mes message',
      (WidgetTester tester) async {
        tester.view.physicalSize = const Size(390, 844);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(tester.view.resetPhysicalSize);

        await tester.pumpWidget(
          const MaterialApp(
            home: PaymentScreen(),
          ),
        );
        await tester.pumpAndSettle();

        // Select Plan 1 Mes
        await tester.tap(find.textContaining('Plan 1 Mes').first);
        await tester.pumpAndSettle();

        await tester.tap(find.text('Solicitar acceso PRO'));
        await tester.pumpAndSettle();

        expect(mockUrlLauncher.lastLaunchedUrl, isNotNull);
        final uri = Uri.parse(mockUrlLauncher.lastLaunchedUrl!);
        final text = uri.queryParameters['text'] ?? '';
        expect(text, contains('Plan 1 Mes'));
        expect(text, anyOf(contains('S/ 15.00'), contains('S/ 15')));
        expect(text, contains('comprobante de pago'));
      },
    );

    testWidgets(
      '4.3 Tapping WhatsApp button after selecting Plan Hasta el Examen launches wa.me with Plan Hasta el Examen message',
      (WidgetTester tester) async {
        tester.view.physicalSize = const Size(390, 844);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(tester.view.resetPhysicalSize);

        await tester.pumpWidget(
          const MaterialApp(
            home: PaymentScreen(),
          ),
        );
        await tester.pumpAndSettle();

        // Select Plan Hasta el Examen
        await tester.tap(find.textContaining('Plan Hasta el Examen').first);
        await tester.pumpAndSettle();

        await tester.tap(find.text('Solicitar acceso PRO'));
        await tester.pumpAndSettle();

        expect(mockUrlLauncher.lastLaunchedUrl, isNotNull);
        final uri = Uri.parse(mockUrlLauncher.lastLaunchedUrl!);
        final text = uri.queryParameters['text'] ?? '';
        expect(text, contains('Plan Hasta el Examen'));
        expect(text, anyOf(contains('S/ 50.00'), contains('S/ 50')));
        expect(text, contains('comprobante de pago'));
      },
    );

    testWidgets(
      '4.4 When WhatsApp launch fails, displays error SnackBar with direct number and copy action',
      (WidgetTester tester) async {
        tester.view.physicalSize = const Size(390, 844);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(tester.view.resetPhysicalSize);

        mockUrlLauncher.throwOnLaunch = true;

        await tester.pumpWidget(
          const MaterialApp(
            home: PaymentScreen(),
          ),
        );
        await tester.pumpAndSettle();

        await tester.tap(find.text('Solicitar acceso PRO'));
        await tester.pumpAndSettle();

        expect(find.byType(SnackBar), findsOneWidget);
        expect(find.textContaining('955285763'), findsOneWidget);
        expect(find.text('Copiar número'), findsOneWidget);
      },
    );
  });

  // ───────────────────────────────────────────────────────────────────────────
  // GROUP 5: Tab Switching & Plan Retention (R4)
  // ───────────────────────────────────────────────────────────────────────────
  group('Group 5: Tab Switching & Plan Retention (R4)', () {
    testWidgets(
      '5.1 Switching to Tab 1 displays all PRO benefits and guarantee pills',
      (WidgetTester tester) async {
        tester.view.physicalSize = const Size(390, 844);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(tester.view.resetPhysicalSize);

        await tester.pumpWidget(
          const MaterialApp(
            home: PaymentScreen(),
          ),
        );
        await tester.pumpAndSettle();

        // Switch to Beneficios PRO tab
        await tester.tap(find.text('Beneficios PRO'));
        await tester.pumpAndSettle();

        // Header in Tab 1
        expect(find.textContaining('¿Qué incluye tu Acceso PRO'), findsOneWidget);

        // All 6 PRO core benefits
        expect(find.textContaining('Temarios Oficiales PNP 2026'), findsOneWidget);
        expect(find.textContaining('Simulacros Oficiales Cronometrados'), findsOneWidget);
        expect(find.textContaining('Radar Predictivo de Riesgo'), findsOneWidget);
        expect(find.textContaining('Bóveda de Errores con Algoritmo SRS'), findsOneWidget);
        expect(find.textContaining('Modo Offline en la App Android'), findsOneWidget);
        expect(find.textContaining('Soporte Prioritario y Nuevas Preguntas'), findsOneWidget);

        // All 4 guarantee pills
        expect(find.text('Pago 100% Seguro'), findsOneWidget);
        expect(find.text('Sin cobros ocultos'), findsOneWidget);
        expect(find.text('Acceso Vitalicio'), findsOneWidget);
        expect(find.text('Para App Android'), findsOneWidget);
      },
    );

    testWidgets(
      '5.2 Returning to Tab 0 via Ver QR de Pago preserves active selected plan',
      (WidgetTester tester) async {
        tester.view.physicalSize = const Size(390, 844);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(tester.view.resetPhysicalSize);

        await tester.pumpWidget(
          const MaterialApp(
            home: PaymentScreen(),
          ),
        );
        await tester.pumpAndSettle();

        // Select Plan 1 Mes (S/ 15)
        final plan1Finder = find.textContaining('Plan 1 Mes');
        expect(plan1Finder, findsAtLeastNWidgets(1));
        await tester.tap(plan1Finder.first);
        await tester.pumpAndSettle();
        expect(find.text('Monto: S/ 15'), findsOneWidget);

        // Switch to Tab 1
        await tester.tap(find.text('Beneficios PRO'));
        await tester.pumpAndSettle();

        // Return button present
        final returnButton = find.textContaining('Ver QR de Pago');
        expect(returnButton, findsOneWidget);
        await tester.tap(returnButton);
        await tester.pumpAndSettle();

        // Back on Tab 0
        expect(find.text('Solicitar acceso PRO'), findsOneWidget);

        // Selected plan retained
        expect(find.text('Monto: S/ 15'), findsOneWidget);
      },
    );
  });

  // ───────────────────────────────────────────────────────────────────────────
  // GROUP 6: Responsive Viewports & Zero-Overflow Validation (AC1, AC2)
  // ───────────────────────────────────────────────────────────────────────────
  group('Group 6: Responsive Viewports & Zero-Overflow Validation (AC1, AC2)', () {
    testWidgets(
      '6.1 Tab 0 renders without RenderFlex overflow on compact mobile viewport (360x640)',
      (WidgetTester tester) async {
        tester.view.physicalSize = const Size(360, 640);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(tester.view.resetPhysicalSize);

        await tester.pumpWidget(
          const MaterialApp(
            home: PaymentScreen(),
          ),
        );
        await tester.pumpAndSettle();

        expect(tester.takeException(), isNull);
        expect(find.text('EDUPOL PRO • Activación'), findsOneWidget);
        expect(find.text('Pago & QR'), findsOneWidget);
        expect(find.text('YAPE OFICIAL'), findsOneWidget);
        expect(find.text('955 285 763'), findsOneWidget);
        expect(find.text('Solicitar acceso PRO'), findsOneWidget);
      },
    );

    testWidgets(
      '6.2 Tab 0 renders cleanly on large mobile (430x932) and desktop (1280x900) clamped to maxWidth 480',
      (WidgetTester tester) async {
        // 1. Large Mobile (430x932)
        tester.view.physicalSize = const Size(430, 932);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(tester.view.resetPhysicalSize);

        await tester.pumpWidget(
          const MaterialApp(
            home: PaymentScreen(),
          ),
        );
        await tester.pumpAndSettle();

        expect(tester.takeException(), isNull);
        expect(find.text('EDUPOL PRO • Activación'), findsOneWidget);
        expect(find.text('Solicitar acceso PRO'), findsOneWidget);

        // 2. Desktop (1280x900)
        tester.view.physicalSize = const Size(1280, 900);
        await tester.pumpWidget(
          const MaterialApp(
            home: PaymentScreen(),
          ),
        );
        await tester.pumpAndSettle();

        expect(tester.takeException(), isNull);

        // Verify maxWidth 480 constraint is clamped
        final constrainedBoxes = tester.widgetList<ConstrainedBox>(
          find.byWidgetPredicate(
            (w) => w is ConstrainedBox && w.constraints.maxWidth == 480,
          ),
        );
        expect(constrainedBoxes.isNotEmpty, isTrue);
      },
    );
  });
}
