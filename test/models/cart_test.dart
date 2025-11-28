import 'package:flutter_test/flutter_test.dart';
import 'package:sandwich_shop/models/cart.dart';
import 'package:sandwich_shop/models/sandwich.dart';
import 'package:sandwich_shop/repositories/pricing_repository.dart';

/// Helper to create sandwiches easily in tests.
Sandwich createSandwich({
  SandwichType type = SandwichType.veggieDelight,
  bool isFootlong = true,
  BreadType breadType = BreadType.white,
}) {
  return Sandwich(type: type, isFootlong: isFootlong, breadType: breadType);
}

void main() {
  group('Cart', () {
    late Cart cart;
    late PricingRepository pricingRepository;

    setUp(() {
      cart = Cart();
      pricingRepository = PricingRepository();
    });

    test('add adds a new sandwich with default quantity 1', () {
      final sandwich = createSandwich();

      cart.add(sandwich);

      expect(cart.items.length, 1);
      expect(cart.items[sandwich], 1);
      expect(cart.getTotalItems(), 1);
    });

    test('add increases quantity when the same sandwich is added again', () {
      final sandwich = createSandwich();

      cart.add(sandwich);
      cart.add(sandwich);

      expect(cart.items.length, 1); // still one entry
      expect(cart.items[sandwich], 2); // quantity increased
      expect(cart.getTotalItems(), 2);
    });

    test('add adds sandwich with custom quantity', () {
      final sandwich = createSandwich();

      cart.add(sandwich, quantity: 3);

      expect(cart.items[sandwich], 3);
      expect(cart.getTotalItems(), 3);
    });

    test('removeSandwich removes sandwich from cart', () {
      final sandwich = createSandwich();

      cart.add(sandwich, quantity: 2);
      cart.removeSandwich(sandwich);

      expect(cart.items.containsKey(sandwich), isFalse);
      expect(cart.getTotalItems(), 0);
    });

    test('updateQuantity changes quantity and removes when quantity <= 0', () {
      final sandwich = createSandwich();

      cart.add(sandwich, quantity: 2);
      cart.updateQuantity(sandwich, 5);

      expect(cart.items[sandwich], 5);
      expect(cart.getTotalItems(), 5);

      // set to zero → should remove
      cart.updateQuantity(sandwich, 0);
      expect(cart.items.containsKey(sandwich), isFalse);
      expect(cart.getTotalItems(), 0);
    });

    test('clearCart removes all items', () {
      final sandwich1 = createSandwich();
      final sandwich2 = createSandwich(
        type: SandwichType.tunaMelt,
        isFootlong: false,
      );

      cart.add(sandwich1, quantity: 2);
      cart.add(sandwich2, quantity: 1);

      cart.clearCart();

      expect(cart.items.isEmpty, isTrue);
      expect(cart.getTotalItems(), 0);
    });

    test('totalPrice matches PricingRepository calculation', () {
      final footlongSandwich = createSandwich(
        type: SandwichType.chickenTeriyaki,
        isFootlong: true,
      );
      final sixInchSandwich = createSandwich(
        type: SandwichType.tunaMelt,
        isFootlong: false,
      );

      cart.add(footlongSandwich, quantity: 2);
      cart.add(sixInchSandwich, quantity: 1);

      final expectedTotal =
          pricingRepository.calculateTotalPrice(isFootlong: true, quantity: 2) +
          pricingRepository.calculateTotalPrice(isFootlong: false, quantity: 1);

      expect(cart.totalPrice, expectedTotal);
    });

    test('items getter returns an unmodifiable map', () {
      final sandwich = createSandwich();

      cart.add(sandwich);

      // Trying to modify the returned map should throw
      expect(() {
        cart.items[sandwich] = 10;
      }, throwsUnsupportedError);
    });

    test('handles empty cart for total price calculation', () {
      expect(cart.totalPrice, 0.0);
    });

    test('handles adding the same sandwich multiple times with quantity', () {
      final sandwich = createSandwich();

      cart.add(sandwich, quantity: 2);
      cart.add(sandwich, quantity: 3);

      expect(cart.items[sandwich], 5);
    });
  });
}
