import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:chicken_la_canyada/main.dart';

void main() {
  testWidgets('App launches successfully', (WidgetTester tester) async {
    // Build our app
    await tester.pumpWidget(const ProviderScope(child: MyApp()));

    // Verify the app starts
    expect(find.byType(MaterialApp), findsOneWidget);
  });

  testWidgets('Splash screen contains restaurant name',
      (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: MyApp()));

    // Verify splash screen content
    expect(find.text('Chicken La Canyada'), findsOneWidget);
  });
}
