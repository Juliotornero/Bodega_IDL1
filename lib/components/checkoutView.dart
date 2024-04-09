import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart'; // Importa el paquete geocoding

class CheckoutView extends StatefulWidget {
  @override
  _CheckoutViewState createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  late String selectedPaymentMethod = 'Cash';
  late String name;
  late String phoneNumber;
  late String address =
      'Obtener Ubicación'; // Inicializa la dirección con un valor predeterminado
  File? imageFile;

  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Proceder al Pago'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DropdownButtonFormField<String>(
              value: selectedPaymentMethod,
              onChanged: (value) {
                setState(() {
                  selectedPaymentMethod = value!;
                });
              },
              items: ['Cash', 'Credit Card', 'Debit Card']
                  .map((method) => DropdownMenuItem(
                        value: method,
                        child: Text(method),
                      ))
                  .toList(),
              decoration: InputDecoration(
                labelText: 'Método de Pago',
              ),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              onChanged: (value) => name = value,
              decoration: InputDecoration(
                labelText: 'Nombre',
              ),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              onChanged: (value) => phoneNumber = value,
              decoration: InputDecoration(
                labelText: 'Teléfono',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                try {
                  Position position = await Geolocator.getCurrentPosition(
                    desiredAccuracy: LocationAccuracy.high,
                  );
                  List<Placemark> placemarks = await placemarkFromCoordinates(
                      position.latitude,
                      position
                          .longitude); // Obtiene la dirección a partir de la latitud y longitud
                  Placemark place = placemarks[0];
                  setState(() {
                    address =
                        '${place.street}, ${place.subLocality}, ${place.locality}'; // Actualiza la dirección con la dirección obtenida
                  });
                } catch (e) {
                  print('Error al obtener la ubicación: $e');
                  setState(() {
                    address = 'Error al obtener la ubicación';
                  });
                }
              },
              child: Text(address), // Muestra la dirección actual
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                // Implementar lógica para tomar una foto
                final pickedFile =
                    await _picker.getImage(source: ImageSource.camera);
                if (pickedFile != null) {
                  setState(() {
                    imageFile = File(pickedFile.path);
                  });
                }
              },
              child: Text('Tomar Foto'),
            ),
            if (imageFile != null) ...[
              SizedBox(height: 16.0),
              Image.file(imageFile!),
            ],
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Mostrar el modal al hacer clic en el botón
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Row(
                        children: [
                          Icon(
                            Icons.check_circle,
                            color: Colors.green,
                          ),
                          SizedBox(width: 8),
                          Text('Pedido Realizado'),
                        ],
                      ),
                      content:
                          Text('Hemos recibido tu pedido, ¡vuelve pronto!'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(); // Cerrar el modal
                            Navigator.popUntil(
                                context,
                                ModalRoute.withName(
                                    '/')); // Volver a la ruta principal
                          },
                          child: Text('Cerrar'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Text('Realizar Compra'),
            ),
          ],
        ),
      ),
    );
  }
}
