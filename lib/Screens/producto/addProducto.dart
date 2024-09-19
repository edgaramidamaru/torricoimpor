import 'package:flutter/material.dart';
import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';
import 'package:torrico_import/Screens/homepage_screen.dart';
import 'package:torrico_import/rounded_button.dart';
import 'package:torrico_import/services/producto_services.dart';
import 'package:nfc_manager/nfc_manager.dart';

class addProducto extends StatefulWidget {
  const addProducto({super.key});

  @override
  State<addProducto> createState() => _addProductoState();
}

class _addProductoState extends State<addProducto> {
  final TextEditingController _nombreproducto = TextEditingController();
  final TextEditingController _descripcion = TextEditingController();
  final TextEditingController _unidad = TextEditingController();
  final TextEditingController _existencia = TextEditingController();
  final TextEditingController _costo = TextEditingController();

  Future<void> writeNfc(BuildContext context, List<NdefRecord> records) async {
    try {
      // Verificar la disponibilidad de NFC
      var availability = await FlutterNfcKit.nfcAvailability;
      if (availability == NFCAvailability.available) {
        // Escribir datos en la etiqueta NFC
        //await FlutterNfcKit.writeNfc(records);
        // Notificar al usuario que la escritura fue exitosa
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Datos escritos en la etiqueta NFC con éxito'),
        ));
      } else {
        // Notificar al usuario que NFC no está disponible en el dispositivo
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('NFC no disponible en este dispositivo'),
        ));
      }
    } catch (e) {
      // Manejar errores de escritura NFC
      print('Error al escribir en la etiqueta NFC: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error al escribir en la etiqueta NFC'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'REGISTRO DE PRODUCTO',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        backgroundColor: Color.fromRGBO(3, 37, 140, 1),
        iconTheme: IconThemeData(color: Colors.white),
        toolbarHeight: 80,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView(
          padding: EdgeInsets.only(
            top: 62,
            left: 12.0,
            right: 12.0,
            bottom: 12.0,
          ),
          children: <Widget>[
            SizedBox(
              height: 70,
              child: TextField(
                controller: _nombreproducto,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: 'Ingrese el nombre del producto',
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
            ),
            SizedBox(
              height: 70,
              child: TextField(
                controller: _descripcion,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: 'Ingrese la descripcion del producto',
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
            ),
            SizedBox(
              height: 70,
              child: TextField(
                controller: _unidad,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: 'Ingrese la unidad del producto',
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
            ),
            SizedBox(
              height: 70,
              child: TextField(
                controller: _existencia,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Ingrese la cantidad de producto',
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
            ),
            SizedBox(
              height: 70,
              child: TextField(
                controller: _costo,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Ingrese el costo del producto',
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 44.0),
            ),
            Container(
              height: 50,
              child: RoundedButton(
                btntext: 'Registrar Producto',
                onBtnPressed: () async {
                  if (_nombreproducto.text.isEmpty ||
                      _descripcion.text.isEmpty ||
                      _unidad.text.isEmpty ||
                      _existencia.text.isEmpty ||
                      _costo.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Por favor complete todos los campos'),
                    ));
                  } else {
                    ProductoServices().addProducto(
                      _nombreproducto.text,
                      _descripcion.text,
                      _unidad.text,
                      int.parse(_existencia.text),
                      int.parse(_costo.text),
                    );

                    // Crear registros NFC
                    List<NdefRecord> records = [
                      NdefRecord.createText(_nombreproducto.text),
                      NdefRecord.createText(_descripcion.text),
                      // Agrega más registros según sea necesario
                    ];

                    // Escribir datos en la etiqueta NFC
                    try {
                      writeNfc(context, records);
                      // Notificar al usuario que la escritura fue exitosa
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content:
                            Text('Datos escritos en la etiqueta NFC con éxito'),
                      ));
                    } catch (e) {
                      // Manejar errores de escritura NFC
                      print('Error al escribir en la etiqueta NFC: $e');
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Error al escribir en la etiqueta NFC'),
                      ));
                    }

                    // Notificar al usuario que el producto se ha registrado
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Producto registrado con éxito'),
                    ));
                  }

                  // Redirigir al usuario a la pantalla de inicio
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
