import 'package:firstapp/models/cart_item.dart';
import 'package:flutter/foundation.dart';

class CartController {
  ValueNotifier<List<CartItem>> cartItems = ValueNotifier<List<CartItem>>([]);

  // Método para obtener el número total de elementos en el carrito
  int getTotalCartItems() {
    int totalItems = 0;
    for (var item in cartItems.value) {
      totalItems += item.quantity;
    }
    return totalItems;
  }

  // Función para agregar un producto al carrito
  void addToCart({
    required String productName,
    required double productPrice,
    required int quantity,
  }) {
    // Verificar si el producto ya está en el carrito
    int existingIndex = cartItems.value.indexWhere((item) => item.productName == productName);
    if (existingIndex != -1) {
      // Si el producto ya está en el carrito, actualizar la cantidad
      cartItems.value[existingIndex].quantity += quantity;
      cartItems.value[existingIndex].updateTotalPrice();
    } else {
      // Si el producto no está en el carrito, agregarlo como un nuevo elemento
      CartItem cartItem = CartItem(
        productName: productName,
        productPrice: productPrice,
        quantity: quantity,
      );
      cartItem.updateTotalPrice();
      cartItems.value = List.from(cartItems.value)..add(cartItem);
    }
  }
}
