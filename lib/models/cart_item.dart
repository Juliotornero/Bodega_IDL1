class CartItem {
  final String productName;
  final double productPrice;
  int quantity;
  double totalPrice; // Precio total del artículo en el carrito

  CartItem({
    required this.productName,
    required this.productPrice,
    this.quantity = 1,
  }) : totalPrice = productPrice * quantity;

  void updateTotalPrice() {
    totalPrice = productPrice * quantity;
  }
}
