import 'package:flutter/material.dart';
import 'package:firstapp/models/cart_item.dart';

class CartView extends StatelessWidget {
  final List<CartItem> cartItems; // Lista de elementos del carrito

  const CartView({
    Key? key,
    required this.cartItems, // Se requiere la lista de elementos del carrito
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Carrito de Compras'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(cartItems[index].productName),
                  subtitle: Text('Cantidad: ${cartItems[index].quantity}'),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      // Lógica para eliminar el producto del carrito
                    },
                  ),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              // Lógica para proceder al pago
            },
            child: Text('Proceder al Pago'),
          ),
        ],
      ),
    );
  }
}
