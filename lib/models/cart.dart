import 'package:sandwich_shop/models/sandwich.dart';
import 'package:sandwich_shop/repositories/pricing_repository.dart';

class Cart {
  // Map of Sandwich -> quantity
  final Map<Sandwich, int> _items = {};
  final PricingRepository _pricingRepository = PricingRepository();

  /// Adds a sandwich with an optional quantity
  /// If the sandwich already exists, its quantity is increased.
  void add(Sandwich sandwich, {int quantity = 1}) {
    if (quantity <= 0) return;

    if (_items.containsKey(sandwich)) {
      _items[sandwich] = _items[sandwich]! + quantity;
    } else {
      _items[sandwich] = quantity;
    }
  }

  /// Backwards-compatible helper
  void addSandwich(Sandwich sandwich) {
    add(sandwich, quantity: 1);
  }

  /// Removes a sandwich completely from the cart.
  void removeSandwich(Sandwich sandwich) {
    _items.remove(sandwich);
  }

  /// Updates the quantity of a sandwich in the cart.
  /// If quantity <= 0, the sandwich is removed.
  void updateQuantity(Sandwich sandwich, int quantity) {
    if (quantity <= 0) {
      _items.remove(sandwich);
    } else {
      _items[sandwich] = quantity;
    }
  }

  /// Returns the total number of items (all quantities) in the cart.
  int getTotalItems() {
    return _items.values.fold(0, (total, quantity) => total + quantity);
  }

  /// Clears the cart.
  void clearCart() {
    _items.clear();
  }

  /// Total price calculation using PricingRepository.calculateTotalPrice
  double get totalPrice {
    double totalPrice = 0.0;
    _items.forEach((sandwich, quantity) {
      totalPrice += _pricingRepository.calculateTotalPrice(
        isFootlong: sandwich.isFootlong,
        quantity: quantity,
      );
    });
    return totalPrice;
  }

  /// Returns an unmodifiable copy of the cart items.
  Map<Sandwich, int> get items {
    return Map.unmodifiable(_items);
  }
}
