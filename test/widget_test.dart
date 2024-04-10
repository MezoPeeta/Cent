// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:cent/src/features/savings/presentation/screens/savings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('test balance card', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: SavingsScreen()));

    //find card
    // // click on the balance card
    // await tester.tap(card);
    // // change value
    // final input = find.ancestor(
    //   of: find.text('My savings'),
    //   matching: find.byType(TextFormField),
    // );

    // await tester.enterText(input, '500');

    // final confirmBtn = find.byType(CustomElevatedButton);

    // await tester.tap(confirmBtn);
    // // value should be changed
    // final text = find.text('500');
    // expect(text, findsOneWidget);
  });
}
