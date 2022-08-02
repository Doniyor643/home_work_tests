
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home_work_tests/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    expect(find.byType(ListView), findsOneWidget);
    expect(find.byIcon(Icons.add), findsOneWidget);
  });
}
