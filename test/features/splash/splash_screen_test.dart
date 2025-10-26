import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness_app/features/splash/splash_screen.dart';

void main() {
  Widget createWidgetUnderTest() {
    return const MaterialApp(
      home: SplashScreen(),
    );
  }

  group('SplashScreen Tests', () {
    testWidgets('should display splash image and scaffold', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      await tester.pump(const Duration(seconds: 3));

      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(Image), findsOneWidget);
    });
  });
}
