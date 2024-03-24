import 'package:flutter/material.dart';
import 'package:firstapp/models/cart_item.dart';

class CartView extends StatefulWidget {
  final List<CartItem> cartItems; // Lista de elementos del carrito

  const CartView({
    Key? key,
    required this.cartItems, // Se requiere la lista de elementos del carrito
  }) : super(key: key);

  @override
  _CartViewState createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  @override
  Widget build(BuildContext context) {
    // Calcular el precio total del carrito sumando los precios totales de todos los elementos
    double totalPrice = widget.cartItems.fold(
        0, (previousValue, cartItem) => previousValue + cartItem.totalPrice);

    return Scaffold(
      appBar: AppBar(
        title: Text('Carrito de Compras'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: widget.cartItems.length,
              itemBuilder: (context, index) {
                final cartItem = widget.cartItems[index];
                return ListTile(
                  title: Text(cartItem.productName),
                  subtitle: Text(
                    'Cantidad: ${cartItem.quantity} - Precio: S/. ${cartItem.totalPrice.toStringAsFixed(2)}',
                  ),
                  // Agregar el botón de eliminar producto del carrito
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      // Eliminar el producto del carrito
                      setState(() {
                        widget.cartItems.removeAt(index);
                      });
                    },
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Total a Pagar: S/. ${totalPrice.toStringAsFixed(2)}', // Total a pagar por todos los elementos del carrito
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
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
