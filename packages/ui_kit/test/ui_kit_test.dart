import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_kit/ui_kit.dart';

void main() {
  testWidgets('PrimaryButton shows provided label',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: PrimaryButton(
            label: 'Open',
            onPressed: _noop,
          ),
        ),
      ),
    );

    expect(find.text('Open'), findsOneWidget);
  });

  testWidgets('SimpleAppBar renders title', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          appBar: SimpleAppBar(title: 'Demo'),
        ),
      ),
    );

    expect(find.text('Demo'), findsOneWidget);
  });
}

void _noop() {}
