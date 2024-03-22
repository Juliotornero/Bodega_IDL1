import 'dart:convert';
import 'package:firstapp/models/product.dart';
import 'package:http/http.dart' as http;

class MarketController {
  Future<List<Product>> getProductsFromApi() async {
    // Solicitud http a la API
    final response = await http.get(Uri.parse('https://shop-api-roan.vercel.app/product'));

    // confirmamos que fue correcta
    if (response.statusCode == 200) {
      // decodificamos los datos
      final List<dynamic> data = jsonDecode(response.body);

      // mapeamos los datos
      List<Product> products = data.map((json) {
        return Product(
          id: json['id'],
          slug: json['slug'],
          name: json['name'],
          description: json['description'],
          price: json['price'].toDouble(),
          stock: json['stock'],
        );
      }).toList();

      // devolvemos los productos
      return products;
    } else {
      //mensaje de error si fallamos en la solicitud
      throw Exception('Failed to load products');
    }
  }
}
