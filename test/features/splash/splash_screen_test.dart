import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness_app/features/splash/splash_screen.dart';

void main() {
  Widget makeTestableWidget() {
    return const MaterialApp(home: SplashScreen());
  }

  group('SplashScreen Widget Tests', () {
    testWidgets('renders splash screen with image', (tester) async {
      await tester.pumpWidget(makeTestableWidget());
      await tester.pump(const Duration(milliseconds: 100));

      expect(find.byType(Image), findsOneWidget);

      expect(find.byType(Scaffold), findsOneWidget);
    });
  });
}
