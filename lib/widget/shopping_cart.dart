class ShoppingCart {
  int total;

  ShoppingCart({required this.total});

  factory ShoppingCart.fromJson(Map<String, dynamic> json) {
    return ShoppingCart(
      total: json["data"] ?? 0,
    );
  }
}
