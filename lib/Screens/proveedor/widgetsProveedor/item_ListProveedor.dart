import 'package:flutter/material.dart';
import 'package:torrico_import/Screens/proveedor/widgetsProveedor/detailProveedor.dart';

class ItemListProveedor extends StatelessWidget {
  const ItemListProveedor({super.key, required this.list});
  final List<Map<String, dynamic>> list;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, i) {
        return Container(
          padding: const EdgeInsets.all(10.0),
          child: Card(
            child: ListTile(
              title: Text(
                list[i]['nombreproveedor'].toString(),
                style: const TextStyle(fontSize: 15.0, color: Colors.black),
              ),
              onTap: () => Navigator.of(context).push(
                new MaterialPageRoute(
                    builder: (BuildContext context) => Detail(
                          list: list,
                          index: i,
                        )),
              ),
            ),
          ),
        );
      },
    );
  }
}
