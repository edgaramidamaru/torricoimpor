import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:torrico_import/services/globals.dart';
import 'package:http/http.dart' as http;

class VentasServices {
  var status;
  var token;
  Future<void> addVenta(
      String nombrecliente, String nombreproducto, String precio) async {
    try {
      var url = Uri.parse('${baseURL}ventas/store');
      final response = await http.post(
        url,
        headers: {
          'Accept': 'application/json',
        },
        body: {
          'nombrecliente': nombrecliente,
          'nombreproducto': nombreproducto,
          'precio': precio
        },
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print('venta creada con exito');
      } else {
        print('Error al realizar la venta:${response.body}');
      }
    } catch (e) {
      print('Error:$e');
    }
  }

  void editVenta(String id, String nombrecliente, String nombreproducto,
      String precio) async {
    final prefs = await SharedPreferences.getInstance();
    const key = 'token';
    final value = prefs.get(key) ?? 0;
    var url = Uri.parse('${baseURL}ventas/update/$id');
    http.put(url, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $value'
    }, body: {
      'nombrecliente': nombrecliente,
      'nombreproducto': nombreproducto,
      'precio': precio
    }).then((response) {
      print('Response status:${response.statusCode}');
      print('Response body:${response.body}');
    });
  }

  void removeVenta(String id) async {
    final prefs = await SharedPreferences.getInstance();
    const key = 'token';
    final value = prefs.get(key) ?? 0;
    var url = Uri.parse('${baseURL}ventas/destroy/$id');
    http.delete(url, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $value'
    }).then((response) {
      print('Response status:${response.statusCode}');
      print('Response body:${response.body}');
    });
  }

  Future<List<Map<String, dynamic>>> getDataVentas() async {
    final prefs = await SharedPreferences.getInstance();
    const key = 'token';
    final value = prefs.get(key) ?? 0;
    var url = Uri.parse('${baseURL}ventas/showto');
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
    print('read:$value');
  }
}
