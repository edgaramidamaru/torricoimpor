import 'package:flutter/material.dart';
import 'package:torrico_import/Screens/homepage_screen.dart';
import 'package:torrico_import/rounded_button.dart';
import 'package:torrico_import/services/pedidos_services.dart';

class Pedidos extends StatefulWidget {
  const Pedidos({super.key});

  @override
  State<Pedidos> createState() => _PedidosState();
}

class _PedidosState extends State<Pedidos> {
  final TextEditingController _nombreproducto = TextEditingController();
  final TextEditingController _descripcionproducto = TextEditingController();
  final TextEditingController _cantidad = TextEditingController();
  final TextEditingController _nombreprovedor = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'REGISTRO DE PEDIDOS',
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
                controller: _nombreproducto,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    hintText: 'Ingrese el nombre del producto',
                    filled: true,
                    fillColor: Colors.white),
              ),
            ),
            SizedBox(
              height: 70,
              child: TextField(
                controller: _descripcionproducto,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText:
                      'ingrese la descripcion del producto que desea realizar el pedido',
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
            ),
            SizedBox(
              height: 70,
              child: TextField(
                controller: _cantidad,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: 'ingrese la cantidad que desea realizar el pedido',
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
            ),
            SizedBox(
              height: 70,
              child: TextField(
                controller: _nombreprovedor,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: 'ingrese el nombre del proveedor',
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
                  btntext: 'Registrar Pedido',
                  onBtnPressed: () async {
                    if (_nombreproducto.text.isEmpty ||
                        _descripcionproducto.text.isEmpty ||
                        _cantidad.text.isEmpty ||
                        _nombreprovedor.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Por favor complete todos los campos'),
                      ));
                    } else {
                      PedidosServices().addPedido(
                        _nombreproducto.text,
                        _descripcionproducto.text,
                        _cantidad.text,
                        _nombreprovedor.text,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Pedido registrado con exito'),
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
