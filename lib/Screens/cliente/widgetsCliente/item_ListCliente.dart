import 'package:flutter/material.dart';
import 'package:torrico_import/Screens/cliente/widgetsCliente/detailCliente.dart';

class ItemListCliente extends StatelessWidget {
  const ItemListCliente({Key? key, required this.list}) : super(key: key);
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
                list[i]['nombrecomcliente'].toString(),
                style: const TextStyle(fontSize: 15.0, color: Colors.black),
              ),
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) => DetailCliente(
                    list: list,
                    index: i,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
