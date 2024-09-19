import 'package:flutter/material.dart';
import 'package:torrico_import/Screens/proveedor/proveedor_screen.dart';
import 'package:torrico_import/rounded_button.dart';
import 'package:torrico_import/services/proveedor_services.dart';

class AddProveedor extends StatefulWidget {
  const AddProveedor({super.key});

  @override
  State<AddProveedor> createState() => _AddProveedorState();
}

class _AddProveedorState extends State<AddProveedor> {
  final TextEditingController _nombreempresa = new TextEditingController();
  final TextEditingController _razonsocial = new TextEditingController();
  final TextEditingController _nombreproveedor = new TextEditingController();
  final TextEditingController _numcontacto = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'REGISTRO DE PROVEEDOR',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
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
          padding: const EdgeInsets.only(
              top: 62, left: 12.0, right: 12.0, bottom: 12.0),
          children: <Widget>[
            SizedBox(
              height: 50,
              child: TextField(
                controller: _nombreempresa,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  hintText: 'Ingrese el nombre de la empresa',
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              height: 50,
              child: TextField(
                controller: _razonsocial,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  hintText: 'Ingrese la razon social de la empresa',
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              height: 50,
              child: TextField(
                controller: _nombreproveedor,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  hintText: 'Ingrese el nombre del proveedor',
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              height: 50,
              child: TextField(
                controller: _numcontacto,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'Ingrese el numero de contacto',
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
                  btntext: 'Registrar Proveedor',
                  onBtnPressed: () {
                    if (_nombreempresa.text.isEmpty ||
                        _razonsocial.text.isEmpty ||
                        _nombreproveedor.text.isEmpty ||
                        _numcontacto.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content:
                              Text('Por favor complete todos los campos')));
                    } else {
                      ProveedorServices().addProveedor(
                          _nombreempresa.text,
                          _razonsocial.text,
                          _nombreproveedor.text,
                          int.parse(_numcontacto.text));
                    }
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Proveedor()),
                    );
                  },
                ))
          ],
        ),
      ),
    );
  }
}
