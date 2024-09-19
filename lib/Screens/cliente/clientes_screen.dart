import 'package:flutter/material.dart';
import 'package:torrico_import/Screens/cliente/addCliente.dart';
import 'package:torrico_import/Screens/cliente/widgetsCliente/item_ListCliente.dart';
import 'package:torrico_import/services/cliente_services.dart';

class ClientesScreen extends StatefulWidget {
  const ClientesScreen({Key? key}) : super(key: key);

  @override
  State<ClientesScreen> createState() => _ClientesScreenState();
}

class _ClientesScreenState extends State<ClientesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Colors.transparent, // Hacer el fondo del Scaffold transparente
      body: Container(
        decoration: BoxDecoration(
          // Usar la imagen como fondo del contenedor
          image: DecorationImage(
            image: AssetImage(
                'assets/images/background.png'), // Reemplaza "tu_imagen_de_fondo.jpg" con la ruta de tu imagen
            fit: BoxFit.cover,
          ),
        ),
        child: FutureBuilder<List<Map<String, dynamic>>>(
          future: ClienteServices().getDataCliente(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError && snapshot.data == null) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }
            if (snapshot.data!.isEmpty) {
              return Text("Sin data", style: TextStyle(color: Colors.red));
            }
            return ItemListCliente(list: snapshot.data!);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const addCliente()),
          );
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 30.0,
        ),
        backgroundColor: const Color.fromRGBO(3, 37, 140, 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(150.0),
        ),
        mini: false,
        elevation: 15,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
