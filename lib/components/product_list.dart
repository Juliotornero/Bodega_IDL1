import 'package:flutter/material.dart';
import 'package:firstapp/controllers/cart_controller.dart'; // Importa el controlador del carrito
import 'package:firstapp/components/product_card.dart';
import 'package:firstapp/models/product.dart';
import 'package:firstapp/controllers/market_controller.dart';

class ProductList extends StatelessWidget {
  final CartController cartController; // Agrega el controlador del carrito como argumento

  const ProductList({Key? key, required this.cartController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Product>>(
      future: MarketController().getProductsFromApi(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (BuildContext context, int index) {
              return ProductCard(
                productName: snapshot.data![index].name,
                productStock: snapshot.data![index].stock,
                productPrice: snapshot.data![index].price,
                cartController: cartController, // Pasa el controlador del carrito al ProductCard
              );
            },
          );
        } else {
          return const Center(
            child: Text('No se encontraron productos.'),
          );
        }
      },
    );
  }
}
