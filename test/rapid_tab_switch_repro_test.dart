// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:learn/features/payment/presentation/payment_screen.dart';

void main() {
  testWidgets('REPRO: Duplicate keys in AnimatedSwitcher during rapid tab flips',
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

    for (int i = 0; i < 5; i++) {
      await tester.tap(find.text('Beneficios PRO'));
      await tester.pump(const Duration(milliseconds: 30));
      await tester.tap(find.text('Pago & QR'));
      await tester.pump(const Duration(milliseconds: 30));
    }
  });
}
