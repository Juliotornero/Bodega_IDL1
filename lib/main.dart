import 'package:firstapp/models/cart_item.dart';
import 'package:flutter/material.dart';
import 'package:firstapp/components/product_list.dart'; // Importar el widget de la lista de productos
import 'package:firstapp/components/cart_view.dart'; // Importar la vista del carrito
import 'package:firstapp/controllers/cart_controller.dart'; // Importar el controlador del carrito

void main() {
  runApp(MaterialApp(
    home: MarketApp(),
  ));
}

class MarketApp extends StatefulWidget {
  const MarketApp({Key? key}) : super(key: key);

  @override
  _MarketAppState createState() => _MarketAppState();
}

class _MarketAppState extends State<MarketApp> {
  final CartController cartController = CartController();

  @override
  void initState() {
    super.initState();
    // Suscribe a los cambios en el número de elementos en el carrito
    cartController.cartItems.addListener(updateCartItemCount);
  }

  @override
  void dispose() {
    // Libera los recursos cuando se destruye el widget
    cartController.cartItems.removeListener(updateCartItemCount);
    super.dispose();
  }

  // Método para actualizar el número de elementos en el carrito
  void updateCartItemCount() {
    setState(() {}); // Reconstruye el widget para actualizar el número
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fruteria Estrellita'),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CartView(
                            cartItems: cartController.cartItems.value)),
                  );
                },
              ),
              Positioned(
                right: 5,
                top: 5,
                child: CircleAvatar(
                  backgroundColor: Colors.green,
                  radius: 10,
                  child: ValueListenableBuilder<List<CartItem>>(
                    valueListenable: cartController.cartItems,
                    builder: (context, items, _) {
                      return Text(
                        '${items.length}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.all(20.0),
            color: Colors.lightGreen[200],
            child: Row(
              children: [
                Image.network(
                  'https://images.unsplash.com/photo-1610832958506-aa56368176cf?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
                const SizedBox(width: 20),
                const Text(
                  'Lista de Productos',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                    fontSize: 24.0,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ProductList(cartController: cartController),
          ),
        ],
      ),
    );
  }
}
