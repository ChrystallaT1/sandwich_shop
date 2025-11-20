class PricingRepository {
  static const int sixInchPrice = 7;
  static const int footlongPrice = 11;

  int calculateTotalPrice({required bool isFootlong, required int quantity}) {
    final pricePerUnit = isFootlong ? footlongPrice : sixInchPrice;
    return quantity * pricePerUnit;
  }
}
