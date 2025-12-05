import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sandwich_shop/models/cart.dart';
import 'package:sandwich_shop/models/sandwich.dart';
import 'package:sandwich_shop/views/cart_screen.dart';

void main() {
  group('CartScreen Tests', () {
    late Cart cart;

    setUp(() {
      cart = Cart();
    });

    Future<void> pumpCartScreen(WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: CartScreen(cart: cart)));
    }

    testWidgets('displays empty cart message when cart is empty', (
      WidgetTester tester,
    ) async {
      await pumpCartScreen(tester);

      expect(find.text('Your cart is empty'), findsOneWidget);
      expect(find.byIcon(Icons.shopping_cart_outlined), findsOneWidget);
    });

    testWidgets('displays cart items with quantity controls', (
      WidgetTester tester,
    ) async {
      final sandwich = Sandwich(
        type: SandwichType.veggieDelight,
        isFootlong: true,
        breadType: BreadType.white,
      );
      cart.add(sandwich, quantity: 2);

      await pumpCartScreen(tester);

      expect(find.text('Veggie Delight'), findsOneWidget);
      expect(find.text('Qty: 2'), findsOneWidget);
      expect(find.byIcon(Icons.add), findsOneWidget);
      expect(find.byIcon(Icons.remove), findsOneWidget);
      expect(find.byIcon(Icons.delete), findsOneWidget);
    });

    testWidgets('increase button increases quantity', (
      WidgetTester tester,
    ) async {
      final sandwich = Sandwich(
        type: SandwichType.veggieDelight,
        isFootlong: true,
        breadType: BreadType.white,
      );
      cart.add(sandwich, quantity: 1);

      await pumpCartScreen(tester);

      await tester.tap(find.byIcon(Icons.add));
      await tester.pump();

      expect(find.text('Qty: 2'), findsOneWidget);
      expect(
        find.text('Veggie Delight quantity increased to 2'),
        findsOneWidget,
      );
    });

    testWidgets('decrease button decreases quantity', (
      WidgetTester tester,
    ) async {
      final sandwich = Sandwich(
        type: SandwichType.veggieDelight,
        isFootlong: true,
        breadType: BreadType.white,
      );
      cart.add(sandwich, quantity: 3);

      await pumpCartScreen(tester);

      await tester.tap(find.byIcon(Icons.remove));
      await tester.pump();

      expect(find.text('Qty: 2'), findsOneWidget);
      expect(
        find.text('Veggie Delight quantity decreased to 2'),
        findsOneWidget,
      );
    });

    testWidgets('decrease button removes item when quantity reaches 0', (
      WidgetTester tester,
    ) async {
      final sandwich = Sandwich(
        type: SandwichType.chickenTeriyaki,
        isFootlong: true,
        breadType: BreadType.white,
      );
      cart.add(sandwich, quantity: 1);

      await pumpCartScreen(tester);

      await tester.tap(find.byIcon(Icons.remove));
      await tester.pumpAndSettle();

      expect(find.text('Chicken Teriyaki'), findsNothing);
      expect(find.text('Your cart is empty'), findsOneWidget);
      expect(find.text('Chicken Teriyaki removed from cart'), findsOneWidget);
    });

    testWidgets('remove button removes item from cart', (
      WidgetTester tester,
    ) async {
      final sandwich = Sandwich(
        type: SandwichType.tunaMelt,
        isFootlong: true,
        breadType: BreadType.white,
      );
      cart.add(sandwich, quantity: 5);

      await pumpCartScreen(tester);

      await tester.tap(find.byIcon(Icons.delete));
      await tester.pumpAndSettle();

      expect(find.text('Tuna Melt'), findsNothing);
      expect(find.text('Your cart is empty'), findsOneWidget);
      expect(find.text('Tuna Melt removed from cart'), findsOneWidget);
    });

    testWidgets('total price updates correctly', (WidgetTester tester) async {
      final sandwich = Sandwich(
        type: SandwichType.veggieDelight,
        isFootlong: true,
        breadType: BreadType.white,
      );
      cart.add(sandwich, quantity: 2);

      await pumpCartScreen(tester);

      final initialTotal = cart.totalPrice;
      expect(
        find.textContaining('Total: £${initialTotal.toStringAsFixed(2)}'),
        findsOneWidget,
      );

      await tester.tap(find.byIcon(Icons.add));
      await tester.pump();

      final newTotal = cart.totalPrice;
      expect(newTotal, greaterThan(initialTotal));
      expect(
        find.textContaining('Total: £${newTotal.toStringAsFixed(2)}'),
        findsOneWidget,
      );
    });
  });
}
