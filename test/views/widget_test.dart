import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sandwich_shop/main.dart';
import 'package:sandwich_shop/models/sandwich.dart';

void main() {
  group('OrderScreen - SnackBar', () {
    testWidgets('displays SnackBar when Add to Cart is tapped', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const App());

      // Verify initial state
      expect(find.byType(SnackBar), findsNothing);

      // Tap the "Add to Cart" button
      await tester.tap(find.widgetWithText(StyledButton, 'Add to Cart'));
      await tester.pump(); // Trigger  animation

      // Verify SnackBar is displayed
      expect(find.byType(SnackBar), findsOneWidget);
      expect(find.textContaining('Added'), findsOneWidget);

      // Wait for the SnackBar to disappear
      await tester.pumpAndSettle(const Duration(seconds: 3));
      expect(find.byType(SnackBar), findsNothing);
    });
  });

  group('OrderScreen - Switch', () {
    testWidgets('toggles between six-inch and footlong', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const App());

      // Verify initial state
      expect(find.textContaining('footlong sandwich'), findsOneWidget);

      // Locate the size switch using its Key and toggle it
      await tester.tap(find.byKey(const Key('sandwich_type_switch')));
      await tester.pump();

      // Verify state after toggling
      expect(find.textContaining('six-inch sandwich'), findsOneWidget);

      // Toggle the switch back
      await tester.tap(find.byKey(const Key('sandwich_type_switch')));
      await tester.pump();

      // Verify state changes back to 'footlong'
      expect(find.textContaining('footlong sandwich'), findsOneWidget);
    });

    testWidgets('toggles between untoasted and toasted', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const App());

      // Verify initial state
      expect(find.text('untoasted'), findsOneWidget);

      // Locate the toasted switch using its Key and toggle it
      await tester.tap(find.byKey(const Key('toasted_switch')));
      await tester.pump();

      // Verify state after toggling
      expect(find.text('toasted'), findsOneWidget);

      // Toggle the switch back
      await tester.tap(find.byKey(const Key('toasted_switch')));
      await tester.pump();

      // Verify state changes back to 'untoasted'
      expect(find.text('untoasted'), findsOneWidget);
    });
  });

  group('App', () {
    testWidgets('renders OrderScreen as home', (WidgetTester tester) async {
      await tester.pumpWidget(const App());
      expect(find.byType(OrderScreen), findsOneWidget);
    });
  });

  group('OrderScreen - Quantity', () {
    testWidgets('shows initial quantity and title', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const App());
      expect(find.text('0 white footlong sandwich(es): '), findsOneWidget);
      expect(find.text('Sandwich Counter'), findsOneWidget);
    });

    testWidgets('increments quantity when Add is tapped', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const App());
      await tester.tap(find.widgetWithText(IconButton, 'Add'));
      await tester.pump();
      expect(find.text('1 white footlong sandwich(es): 🥪'), findsOneWidget);
    });

    testWidgets('decrements quantity when Remove is tapped', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const App());
      await tester.tap(find.widgetWithText(IconButton, 'Add'));
      await tester.pump();
      expect(find.text('1 white footlong sandwich(es): 🥪'), findsOneWidget);
      await tester.tap(find.widgetWithText(IconButton, 'Remove'));
      await tester.pump();
      expect(find.text('0 white footlong sandwich(es): '), findsOneWidget);
    });

    testWidgets('does not decrement below zero', (WidgetTester tester) async {
      await tester.pumpWidget(const App());
      expect(find.text('0 white footlong sandwich(es): '), findsOneWidget);
      await tester.tap(find.widgetWithText(IconButton, 'Remove'));
      await tester.pump();
      expect(find.text('0 white footlong sandwich(es): '), findsOneWidget);
    });

    testWidgets('does not increment above maxQuantity', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const App());
      for (int i = 0; i < 10; i++) {
        await tester.tap(find.widgetWithText(IconButton, 'Add'));
        await tester.pump();
      }
      expect(
        find.text('10 white footlong sandwich(es): 🥪🥪🥪🥪🥪🥪🥪🥪🥪🥪'),
        findsOneWidget,
      );
    });
  });

  group('OrderScreen - Controls', () {
    testWidgets('changes bread type with DropdownMenu', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const App());
      await tester.tap(find.byType(DropdownMenu<BreadType>));
      await tester.pumpAndSettle();
      await tester.tap(find.text('wheat').last);
      await tester.pumpAndSettle();
      expect(find.textContaining('wheat footlong sandwich'), findsOneWidget);
      await tester.tap(find.byType(DropdownMenu<BreadType>));
      await tester.pumpAndSettle();
      await tester.tap(find.text('wholemeal').last);
      await tester.pumpAndSettle();
      expect(
        find.textContaining('wholemeal footlong sandwich'),
        findsOneWidget,
      );
    });

    testWidgets('updates note with TextField', (WidgetTester tester) async {
      await tester.pumpWidget(const App());
      await tester.enterText(
        find.byKey(const Key('notes_textfield')),
        'Extra mayo',
      );
      await tester.pump();
      expect(find.text('Note: Extra mayo'), findsOneWidget);
    });
  });

  group('StyledButton', () {
    testWidgets('renders with icon and label', (WidgetTester tester) async {
      const testButton = StyledButton(
        onPressed: null,
        icon: Icons.add,
        label: 'Test Add',
        backgroundColor: Colors.blue,
      );
      const testApp = MaterialApp(home: Scaffold(body: testButton));
      await tester.pumpWidget(testApp);
      expect(find.byIcon(Icons.add), findsOneWidget);
      expect(find.text('Test Add'), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
    });
  });
}
