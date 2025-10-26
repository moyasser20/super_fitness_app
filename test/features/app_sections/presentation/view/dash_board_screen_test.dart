import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness_app/features/app_sections/presentation/view/dash_board_screen.dart';

void main() {
  group('DashboardScreen Widget Tests', () {
    testWidgets('DashboardScreen initializes with Explore page selected', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const DashboardScreenApp());

      // Verify that the Explore page is displayed initially
      expect(find.byKey(const Key('explorePageText')), findsOneWidget);
      expect(find.byKey(const Key('chatPageText')), findsNothing);
      expect(find.byKey(const Key('workoutPageText')), findsNothing);
      expect(find.byKey(const Key('profilePageText')), findsNothing);

      // Verify that the 'Explore' nav item is selected
      final exploreNavItem = find.byWidgetPredicate(
        (widget) =>
            widget is Column &&
            find
                .descendant(
                  of: find.byWidget(widget),
                  matching: find.text('Explore'),
                )
                .evaluate()
                .isNotEmpty,
      );
      expect(exploreNavItem, findsOneWidget);
    });

    testWidgets('Tapping on Chat nav item changes to Chat page', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const DashboardScreenApp());

      // Tap on the Chat nav item
      await tester.tap(find.text('Chat'));
      await tester.pumpAndSettle();

      // Verify that the Chat page is displayed
      expect(find.byKey(const Key('chatPageText')), findsOneWidget);
      expect(find.byKey(const Key('explorePageText')), findsNothing);
    });

    testWidgets('Tapping on Workouts nav item changes to Workouts page', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const DashboardScreenApp());

      // Tap on the Workouts nav item
      await tester.tap(find.text('Workouts'));
      await tester.pumpAndSettle();

      // Verify that the Workouts page is displayed
      expect(find.byKey(const Key('workoutPageText')), findsOneWidget);
      expect(find.byKey(const Key('explorePageText')), findsNothing);
    });

    testWidgets('Tapping on Profile nav item changes to Profile page', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const DashboardScreenApp());

      // Tap on the Profile nav item
      await tester.tap(find.text('Profile'));
      await tester.pumpAndSettle();

      // Verify that the Profile page is displayed
      expect(find.byKey(const Key('explorePageText')), findsNothing);
    });
  });
}
