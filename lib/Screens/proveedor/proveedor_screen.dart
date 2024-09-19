import 'package:flutter/material.dart';
import 'package:torrico_import/Screens/proveedor/addProveedor.dart';
import 'package:torrico_import/services/proveedor_services.dart';

import 'widgetsProveedor/item_ListProveedor.dart';

class Proveedor extends StatefulWidget {
  const Proveedor({super.key});

  @override
  State<Proveedor> createState() => _ProveedorState();
}

class _ProveedorState extends State<Proveedor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'PROVEEDORES',
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
        child: FutureBuilder<List<Map<String, dynamic>>>(
          future: ProveedorServices().getData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError && snapshot.data == null) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            }
            if (snapshot.data!.isEmpty) {
              return const Text(
                "Sin data",
                style: TextStyle(color: Colors.red),
              );
            }
            return ItemListProveedor(list: snapshot.data!);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddProveedor()),
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
