import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:super_fitness_app/features/onboarding/onboaarding_screen.dart';

void main() {
  group('OnboardingScreen Widget Tests', () {
    testWidgets('renders onboarding screen with PageView and buttons', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(size: Size(800, 1000)),
            child: const OnboardingScreen(),
          ),
        ),
      );

      expect(find.byType(PageView), findsOneWidget);

      expect(find.text('Skip'), findsOneWidget);

      expect(find.text('Next'), findsOneWidget);

      expect(find.byType(SmoothPageIndicator), findsOneWidget);
    });

    testWidgets('changes page on swipe', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(size: Size(800, 1000)),
            child: const OnboardingScreen(),
          ),
        ),
      );

      expect(
        find.text('The Price Of Excellence\nIs Discipline'),
        findsOneWidget,
      );

      await tester.drag(find.byType(PageView), const Offset(-500, 0));
      await tester.pumpAndSettle();

      expect(find.text('Fitness Has Never Been So\nMuch Fun'), findsOneWidget);
    });

    testWidgets('shows Back and Next buttons after first page', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(size: Size(800, 1000)),
            child: const OnboardingScreen(),
          ),
        ),
      );

      await tester.drag(find.byType(PageView), const Offset(-500, 0));
      await tester.pumpAndSettle();

      expect(find.text('Back'), findsOneWidget);
      expect(find.text('Next'), findsOneWidget);
    });

    testWidgets('shows Do it button on last page', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(size: Size(800, 1000)),
            child: const OnboardingScreen(),
          ),
        ),
      );

      await tester.drag(find.byType(PageView), const Offset(-500, 0));
      await tester.pumpAndSettle();
      await tester.drag(find.byType(PageView), const Offset(-500, 0));
      await tester.pumpAndSettle();

      expect(find.text('Do it'), findsOneWidget);
    });
  });
}
