import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sandwich_shop/models/cart.dart';
import 'package:sandwich_shop/models/sandwich.dart';
import 'package:sandwich_shop/views/checkout_screen.dart';

void main() {
  group('CheckoutScreen Tests', () {
    late Cart cart;

    setUp(() {
      cart = Cart();
    });

    Future<void> pumpCheckoutScreen(WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: CheckoutScreen(cart: cart)));
    }

    testWidgets('displays order summary with cart items', (
      WidgetTester tester,
    ) async {
      final sandwich = Sandwich(
        type: SandwichType.veggieDelight,
        isFootlong: true,
        breadType: BreadType.white,
      );
      cart.add(sandwich, quantity: 2);

      await pumpCheckoutScreen(tester);

      expect(find.text('Order Summary'), findsOneWidget);
      expect(find.text('2x Veggie Delight'), findsOneWidget);
    });

    testWidgets('displays total price', (WidgetTester tester) async {
      final sandwich = Sandwich(
        type: SandwichType.tunaMelt,
        isFootlong: true,
        breadType: BreadType.white,
      );
      cart.add(sandwich, quantity: 2);

      await pumpCheckoutScreen(tester);

      final totalPrice = cart.totalPrice;
      expect(find.text('Total:'), findsOneWidget);
      expect(find.text('£${totalPrice.toStringAsFixed(2)}'), findsOneWidget);
    });

    testWidgets('displays confirm payment button', (WidgetTester tester) async {
      await pumpCheckoutScreen(tester);

      expect(find.text('Confirm Payment'), findsOneWidget);
    });

    testWidgets('shows processing indicator when payment is processing', (
      WidgetTester tester,
    ) async {
      await pumpCheckoutScreen(tester);

      await tester.tap(find.text('Confirm Payment'));
      await tester.pump();

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('Processing payment...'), findsOneWidget);
    });
  });
}
