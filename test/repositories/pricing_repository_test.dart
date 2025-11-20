import 'package:flutter_test/flutter_test.dart';
import 'package:sandwich_shop/repositories/pricing_repository.dart';

void main() {
  final pricing = PricingRepository();

  test('calculates six-inch price correctly', () {
    expect(pricing.calculateTotalPrice(isFootlong: false, quantity: 2), 14);
  });

  test('calculates footlong price correctly', () {
    expect(pricing.calculateTotalPrice(isFootlong: true, quantity: 3), 33);
  });
}
