import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:torrico_import/services/globals.dart';

class Proveedor extends StatefulWidget {
  const Proveedor({super.key});

  @override
  State<Proveedor> createState() => _ProveedorState();
}

class _ProveedorState extends State<Proveedor> {
  late Future<List<Map<String, dynamic>>> _dataFuture;

  Future<List<Map<String, dynamic>>> getData() async {
    final response = await http.get(Uri.parse(baseURL + 'proveedor/showto'));
    if (response.statusCode == 200) {
      final dynamic responseData = json.decode(response.body);
      if (responseData is List) {
        return responseData.cast<Map<String, dynamic>>().toList();
      } else if (responseData is Map<String, dynamic>) {
        return [responseData];
      } else {
        throw Exception('Response data is not a List or Map');
      }
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  }

  @override
  void initState() {
    super.initState();
    _dataFuture = getData();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
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
          future: _dataFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else {
              return ItemList(list: snapshot.data!);
            }
          },
        ),
      ),
    );
  }
}

class ItemList extends StatelessWidget {
  final List<Map<String, dynamic>> list;

  const ItemList({required this.list});

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
                list[i]['nombreproveedor'].toString(),
                style: TextStyle(fontSize: 15.0, color: Colors.black),
              ),
              onTap: () {
                //detail
              },
            ),
          ),
        );
      },
    );
  }
}
