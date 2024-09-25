import 'package:flutter/material.dart';
import 'package:torrico_import/Screens/homepage_screen.dart';
import 'package:torrico_import/rounded_button.dart';
import 'package:torrico_import/services/ventas_services.dart';

class Ventas extends StatefulWidget {
  const Ventas({super.key});

  @override
  State<Ventas> createState() => _VentasState();
}

class _VentasState extends State<Ventas> {
  final TextEditingController _nombrecliente = TextEditingController();
  final TextEditingController _nombreproducto = TextEditingController();
  final TextEditingController _precio = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: const Text(
          'VENTAS',
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
          ),
        ),
        backgroundColor: const Color.fromRGBO(3, 37, 140, 1),
        iconTheme: const IconThemeData(color: Colors.white),
        toolbarHeight: 80,
      ),
      body: Container(
        decoration: const BoxDecoration(
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
                controller: _nombrecliente,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    hintText: 'Ingrese nombre del cliente',
                    filled: true,
                    fillColor: Colors.white),
              ),
            ),
            SizedBox(
              height: 70,
              child: TextField(
                controller: _nombreproducto,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    hintText: 'Ingrese nombre del producto',
                    filled: true,
                    fillColor: Colors.white),
              ),
            ),
            SizedBox(
              height: 70,
              child: TextField(
                controller: _precio,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    hintText: 'Ingrese  el monto del producto',
                    filled: true,
                    fillColor: Colors.white),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 44.0),
            ),
            Container(
              height: 50,
              child: RoundedButton(
                  btntext: 'Realizar venta',
                  onBtnPressed: () async {
                    if (_nombrecliente.text.isEmpty ||
                        _nombreproducto.text.isEmpty ||
                        _precio.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Por favor complete todo los campos'),
                      ));
                    } else {
                      VentasServices().addVenta(
                        _nombrecliente.text,
                        _nombreproducto.text,
                        _precio.text,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Venta registrada con exito'),
                      ));
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()),
                      );
                    }
                  }),
            )
          ],
        ),
      ),
    );
  }
}
