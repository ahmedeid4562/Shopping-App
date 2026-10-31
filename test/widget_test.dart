import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:shopping_app/features/presentation/view/screens/splash_screen.dart';

void main() {
  testWidgets('Splash screen displays correctly', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: SplashScreen(),
      ),
    );

    expect(find.text('Shopping App'), findsOneWidget);

    expect(find.text('Your style, your choice'), findsOneWidget);

    expect(
      find.byType(CircularProgressIndicator),
      findsOneWidget,
    );
  });
}
