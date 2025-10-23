class PriceCalculator {
  static double calculateTotal(List<Map<String, dynamic>> cartItems) {
    double total = 0;
    for (var item in cartItems) {
      total += item['price'] * item['quantity'];
    }
    return total;
  }

  static double calculateDeliveryFee(double total, double distance) {
    if (total > 100) {
      return 0; // Livraison gratuite au-dessus de 100 DH
    }

    if (distance < 5) {
      return 15.0;
    } else if (distance < 10) {
      return 25.0;
    } else {
      return 35.0;
    }
  }
}
