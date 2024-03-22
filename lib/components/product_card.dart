import 'package:flutter/material.dart';
import 'package:firstapp/controllers/cart_controller.dart'; // Importa el controlador del carrito

class ProductCard extends StatefulWidget {
  final String productName;
  int productStock; // Cambia productStock a no final
  final double productPrice;
  final CartController
      cartController; // Agrega el controlador del carrito como argumento

  ProductCard({
    required this.productName,
    required this.productStock,
    required this.productPrice,
    required this.cartController, // Añade el controlador del carrito como argumento
    Key? key,
  }) : super(key: key);

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    bool noStock = widget.productStock == 0;

    return Card(
      margin: const EdgeInsets.all(10.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.productName,
              style: const TextStyle(
                fontFamily: 'Roboto',
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            SizedBox(height: 5), // Espacio entre el nombre y el stock
            Text(
              'Stock: ${noStock ? "No hay stock" : widget.productStock}',
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 16.0,
                color: noStock ? Colors.red : null,
              ),
            ),
            SizedBox(height: 5), // Espacio entre el stock y el precio
            Text(
              'S/.${widget.productPrice.toStringAsFixed(2)}',
              style: const TextStyle(
                fontFamily: 'Roboto',
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 10), // Espacio entre el precio y los botones
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if (quantity > 1) {
                        quantity--;
                      }
                    });
                  },
                  child: Icon(Icons.remove),
                ),
                SizedBox(width: 1),
                Text(
                  quantity.toString(),
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(width: 1),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if (!noStock) {
                        quantity++;
                      }
                    });
                  },
                  child: Icon(Icons.add),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ), // Espacio entre los botones y el botón "Añadir al carrito"
            ElevatedButton(
              onPressed: noStock
                  ? null
                  : () {
                      // Verificar si la cantidad seleccionada excede el stock disponible
                      if (quantity > widget.productStock) {
                        // Si excede, mostrar un AlertDialog indicando que ha excedido el stock
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Row(
                                children: [
                                  Icon(
                                    Icons.warning,
                                    color: Colors.red,
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    'Stock Insuficiente',
                                    style: TextStyle(
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                              content: Text(
                                  'No puedes agregar más productos de los disponibles en el stock.'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Entendido'),
                                ),
                              ],
                            );
                          },
                        );
                      } else {
                        // Si no excede el stock, añadir el producto al carrito
                        widget.cartController.addToCart(
                          productName: widget.productName,
                          productPrice: widget.productPrice,
                          quantity: quantity,
                        );
                        // Mostrar un snackbar indicando que el producto fue agregado correctamente
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Row(
                              children: [
                                Icon(Icons.check, color: Colors.green),
                                SizedBox(width: 8),
                                Text('Producto agregado correctamente'),
                              ],
                            ),
                            backgroundColor: Colors.green[600],
                          ),
                        );
                        // Actualizar el stock del producto
                        setState(() {
                          widget.productStock -= quantity;
                          quantity = 1;
                        });
                      }
                    },
              child: Text('Añadir al carrito'),
            ),
          ],
        ),
      ),
    );
  }
}
