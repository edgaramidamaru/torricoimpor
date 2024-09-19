import 'package:flutter/material.dart';
import 'package:torrico_import/Screens/cliente/widgetsCliente/detailCliente.dart';
import 'package:torrico_import/Screens/producto/widgetsProducto/detailProducto.dart';

class ItemListProducto extends StatelessWidget {
  const ItemListProducto({super.key, required this.list});
  final List<Map<String, dynamic>> list;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, i) {
        return Container(
          padding: EdgeInsets.all(10.0),
          child: Card(
            child: ListTile(
              title: Text(
                list[i]['nombreproducto'].toString(),
                style: TextStyle(fontSize: 15.0, color: Colors.black),
              ),
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) =>
                      DetailProducto(index: i, list: list),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
