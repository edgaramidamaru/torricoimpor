import 'package:flutter/material.dart';
import 'package:torrico_import/Screens/producto/addProducto.dart';
import 'package:torrico_import/Screens/producto/widgetsProducto/item_ListProducto.dart';
import 'package:torrico_import/services/producto_services.dart';

class ProductosScreen extends StatefulWidget {
  const ProductosScreen({Key? key}) : super(key: key);

  @override
  State<ProductosScreen> createState() => _ProductosScreenState();
}

class _ProductosScreenState extends State<ProductosScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: FutureBuilder<List<Map<String, dynamic>>>(
          future: ProductoServices().getDataProductos(),
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
            return ItemListProducto(list: snapshot.data!);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => addProducto()));
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
