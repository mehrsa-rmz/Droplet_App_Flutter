
class TPricingCalculator {

  /// -- Calculate Price based on tax and shipping
  // TODO: add the rest of the functions from the code and revise the price function
  static double calculateTotalPrice(List<double> productPrices, double deliveryCost, {double discount = 0, String discountType = ''}){
    double total = 0;
    for (double i in productPrices) {total += i;}
    total -= discountType == '-' ? discount : discountType == '%' ? (total * discount / 100) : 0;
    total += deliveryCost;

    return total;
  }

  /// -- Sum all cart values and return total amount
  // TODO: adauga si pt cart
  // static double calculateCartTotal(CartModel cart) {
  //   return cart.items.map((e) => e.price).fold(0, (previousPrice, currentPrice) => previousPrice + (currentPrice));
  // }
}
