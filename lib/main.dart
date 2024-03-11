import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: MarketApp(),
  ));
}

class MarketApp extends StatelessWidget {
  const MarketApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fruteria Estrellita'),
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
                    fontWeight: FontWeight.bold,
                    fontSize: 24.0,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: const [
                ProductCard(
                  productName: 'Papaya',
                  productContent: '1kg',
                  productPrice: 10.00,
                  imageUrl: 'https://images.unsplash.com/photo-1517282009859-f000ec3b26fe?q=80&w=1587&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                ),
                ProductCard(
                  productName: 'Pera',
                  productContent: '500g',
                  productPrice: 8.50,
                  imageUrl: 'https://plus.unsplash.com/premium_photo-1669905375079-5d7e074fc123?q=80&w=1587&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                ),
                ProductCard(
                  productName: 'Manzana',
                  productContent: '750g',
                  productPrice: 12.00,
                  imageUrl: 'https://images.unsplash.com/photo-1579613832125-5d34a13ffe2a?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final String productName;
  final String productContent;
  final double productPrice;
  final String imageUrl;

  const ProductCard({
    required this.productName,
    required this.productContent,
    required this.productPrice,
    required this.imageUrl,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Image.network(
              imageUrl,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
            const SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  productName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
                Text(
                  'Contenido: $productContent',
                  style: const TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Text(
              'S/.${productPrice.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 16.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
