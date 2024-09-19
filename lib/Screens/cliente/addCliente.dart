import 'package:flutter/material.dart';
import 'package:torrico_import/Screens/homepage_screen.dart';
import 'package:torrico_import/rounded_button.dart';
import 'package:torrico_import/services/cliente_services.dart';

class addCliente extends StatefulWidget {
  const addCliente({super.key});

  @override
  State<addCliente> createState() => _addClienteState();
}

class _addClienteState extends State<addCliente> {
  final TextEditingController _nombrecomcliente = new TextEditingController();
  final TextEditingController _carnet = new TextEditingController();
  final TextEditingController _celular = new TextEditingController();
  final TextEditingController _direccion = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'REGISTRO DE CLIENTE',
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
              fit: BoxFit.cover),
        ),
        child: ListView(
          padding:
              EdgeInsets.only(top: 62, left: 12.0, right: 12.0, bottom: 12.0),
          children: <Widget>[
            SizedBox(
              height: 70,
              child: TextField(
                controller: _nombrecomcliente,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: 'ingrese el nombre del cliente',
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
            ),
            SizedBox(
              height: 70,
              child: TextField(
                controller: _carnet,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: 'ingrese el numero de carnet',
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
            ),
            SizedBox(
              height: 70,
              child: TextField(
                controller: _celular,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'ingrese el numero del cliente',
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
            ),
            SizedBox(
              height: 70,
              child: TextField(
                controller: _direccion,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: 'ingrese la direccion del cliente',
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
                  btntext: 'Registrar Cliente',
                  onBtnPressed: () {
                    if (_nombrecomcliente.text.isEmpty ||
                        _carnet.text.isEmpty ||
                        _celular.text.isEmpty ||
                        _direccion.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content:
                              Text('Por favor complete todos los campos')));
                    } else {
                      ClienteServices().addCliente(
                          _nombrecomcliente.text,
                          _carnet.text,
                          int.parse(_celular.text),
                          _direccion.text);
                    }
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
