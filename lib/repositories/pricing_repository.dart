class PricingRepository {
  static const double sixInchPrice = 7.0;
  static const double footlongPrice = 11.0;

  double calculateTotalPrice(int quantity, bool isFootlong) {
    return (isFootlong ? footlongPrice : sixInchPrice) * quantity;
  }
}