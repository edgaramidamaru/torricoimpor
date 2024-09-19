import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:torrico_import/services/globals.dart';
import 'package:http/http.dart' as http;

class ProductoServices {
  var status;
  var token;
  Future<void> addProducto(String nombreproducto, String descripcion,
      String unidad, int existencia, int costo) async {
    try {
      var url = Uri.parse('${baseURL}productos/store');
      final response = await http.post(
        url,
        headers: {
          'Accept': 'application/json',
        },
        body: {
          'nombreproducto': nombreproducto,
          'descripcion': descripcion,
          'unidad': unidad,
          'existencia': existencia.toString(),
          'costo': costo.toString()
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print('Producto creado exitosamente');
      } else {
        print('Error al crear el producto: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  void editProducto(String id, nombreproducto, String descripcion,
      String unidad, int existencia, int costo) async {
    final prefs = await SharedPreferences.getInstance();
    const key = 'token';
    final value = prefs.get(key) ?? 0;
    var url = Uri.parse('${baseURL}productos/update/$id');
    http.put(url, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $value'
    }, body: {
      'nombreproducto': nombreproducto,
      'descripcion': descripcion,
      'unidad': unidad,
      'existencia': existencia.toString(),
      'costo': costo.toString()
    }).then((response) {
      print('Response status : ${response.statusCode}');
      print('Response body : ${response.body}');
    });
  }

  void removeProducto(String id) async {
    final prefs = await SharedPreferences.getInstance();
    const key = 'token';
    final value = prefs.get(key) ?? 0;
    var url = Uri.parse('${baseURL}productos/destroy/$id');

    http.delete(url, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $value'
    }).then((response) {
      print('Response status : ${response.statusCode}');
      print('Response body : ${response.body}');
    });
  }

  Future<List<Map<String, dynamic>>> getDataProductos() async {
    final prefs = await SharedPreferences.getInstance();
    const key = 'token';
    final value = prefs.get(key) ?? 0;

    var url = Uri.parse('${baseURL}productos/showto');

    final response = await http.get(
      url,
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $value'},
    );
    print(json.decode(response.body));
    final data = json.decode(response.body) as Map<String, dynamic>;
    return response.statusCode == 200
        ? List<Map<String, dynamic>>.from(data["data"])
        : [];
  }

  _save(String token) async {
    final prefs = await SharedPreferences.getInstance();
    const key = 'token';
    final value = token;
    prefs.setString(key, value);
  }

  read() async {
    final prefs = await SharedPreferences.getInstance();
    const key = 'token';
    final value = prefs.get(key) ?? 0;
    print('read : $value');
  }
}
