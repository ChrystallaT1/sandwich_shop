import 'package:sandwich_shop/models/sandwich.dart';
import 'package:sandwich_shop/repositories/pricing_repository.dart';

class Cart {
  final Map<Sandwich, int> _items = {}; // quantities
  final PricingRepository _pricingRepository = PricingRepository();

  // Adds a sandwich to the cart or increases its quantity if it already exists.
  void addSandwich(Sandwich sandwich) {
    if (_items.containsKey(sandwich)) {
      _items[sandwich] = _items[sandwich]! + 1;
    } else {
      _items[sandwich] = 1;
    }
  }

  // Removes a sandwich
  void removeSandwich(Sandwich sandwich) {
    _items.remove(sandwich);
  }

  /// Updates the quantity of a sandwich in the cart.
  /// If quantity = 0, the sandwich is removed from the cart.
  void updateQuantity(Sandwich sandwich, int quantity) {
    if (quantity <= 0) {
      _items.remove(sandwich);
    } else {
      _items[sandwich] = quantity;
    }
  }

  /// Returns the total number of items in the cart.
  int getTotalItems() {
    return _items.values.fold(0, (total, quantity) => total + quantity);
  }

  void clearCart() {
    _items.clear(); //clears item
  }

  //total price calculation
  double calculateTotalPrice() {
    double totalPrice = 0.0;
    _items.forEach((sandwich, quantity) {
      totalPrice += _pricingRepository.calculateTotalPrice(
        isFootlong: sandwich.isFootlong,
        quantity: quantity,
      );
    });
    return totalPrice;
  }

  //list of sandwiches with quantities
  Map<Sandwich, int> getItems() {
    return Map.unmodifiable(
      _items,
    ); // Returns an unmodifiable copy of the cart items
  }
}
