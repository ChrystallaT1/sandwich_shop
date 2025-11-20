import 'package:flutter_test/flutter_test.dart';
import 'package:sandwich_shop/models/cart.dart';
import 'package:sandwich_shop/models/sandwich.dart';
import 'package:sandwich_shop/repositories/pricing_repository.dart';

void main() {
  group('Cart', () {
    late Cart cart;
    late Sandwich sandwich1;
    late Sandwich sandwich2;

    setUp(() {
      cart = Cart();
      sandwich1 = Sandwich(
        type: SandwichType.veggieDelight,
        isFootlong: true,
        breadType: BreadType.white,
      );
      sandwich2 = Sandwich(
        type: SandwichType.chickenTeriyaki,
        isFootlong: false,
        breadType: BreadType.wheat,
      );
    });

    test('adds sandwiches to the cart', () {
      cart.addSandwich(sandwich1);
      cart.addSandwich(sandwich2);

      expect(cart.getItems().length, 2);
      expect(cart.getItems()[sandwich1], 1);
      expect(cart.getItems()[sandwich2], 1);
    });

    test('increases quantity of an existing sandwich', () {
      cart.addSandwich(sandwich1);
      cart.addSandwich(sandwich1);

      expect(cart.getItems()[sandwich1], 2);
    });

    test('removes a sandwich from the cart', () {
      cart.addSandwich(sandwich1);
      cart.addSandwich(sandwich2);

      cart.removeSandwich(sandwich1);

      expect(cart.getItems().length, 1);
      expect(cart.getItems().containsKey(sandwich1), false);
    });

    test('updates the quantity of a sandwich', () {
      cart.addSandwich(sandwich1);
      cart.updateQuantity(sandwich1, 5);

      expect(cart.getItems()[sandwich1], 5);

      cart.updateQuantity(sandwich1, 0);

      expect(cart.getItems().containsKey(sandwich1), false);
    });

    test('calculates the total number of items in the cart', () {
      cart.addSandwich(sandwich1);
      cart.addSandwich(sandwich2);
      cart.addSandwich(sandwich1);

      expect(cart.getTotalItems(), 3);
    });

    test('clears the cart', () {
      cart.addSandwich(sandwich1);
      cart.addSandwich(sandwich2);

      cart.clearCart();

      expect(cart.getItems().length, 0);
      expect(cart.getTotalItems(), 0);
    });

    test('calculates the total price of the order', () {
      cart.addSandwich(sandwich1); // Footlong Veggie Delight: £11
      cart.addSandwich(sandwich2); // Six-inch Chicken Teriyaki: £7
      cart.addSandwich(sandwich1); // Another Footlong Veggie Delight: £11

      expect(cart.calculateTotalPrice(), 29); // Total: £11 + £7 + £11 = £29
    });
  });
}
