import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:torrico_import/services/globals.dart';
import 'package:http/http.dart' as http;

class PedidosServices {
  var status;
  var token;
  Future<void> addPedido(String nombreproducto, String descripcionproducto,
      String cantidad, String nombreprovedor) async {
    try {
      var url = Uri.parse('${baseURL}pedidos/store');
      final response = await http.post(
        url,
        headers: {
          'Accept': 'application/json',
        },
        body: {
          'nombreproducto': nombreproducto,
          'descripcionproducto': descripcionproducto,
          'cantidad': cantidad,
          'nombreprovedor': nombreprovedor
        },
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print('Pedido creado exitosamente');
      } else {
        print('Error al crear el pedido:${response.body}');
      }
    } catch (e) {
      print('Error:$e');
    }
  }

  void editPedido(String id, String nombreproducto, String descripcionproducto,
      String cantidad, String nombreprovedor) async {
    final prefs = await SharedPreferences.getInstance();
    const key = 'token';
    final value = prefs.get(key) ?? 0;
    var url = Uri.parse('${baseURL}pedidos/update/$id');
    http.put(url, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $value'
    }, body: {
      'nombreproducto': nombreproducto,
      'descripcionproducto': descripcionproducto,
      'cantidad': cantidad,
      'nombreprovedor': nombreprovedor
    }).then((response) {
      print('Response status:${response.statusCode}');
      print('Response body:${response.body}');
    });
  }

  void removePedido(String id) async {
    final prefs = await SharedPreferences.getInstance();
    const key = 'token';
    final value = prefs.get(key) ?? 0;
    var url = Uri.parse('${baseURL}pedidos/destroy/$id');
    http.delete(url, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $value'
    }).then((response) {
      print('Response status : ${response.statusCode}');
      print('Response body : ${response.body}');
    });
  }

  Future<List<Map<String, dynamic>>> getDataPedidos() async {
    final prefs = await SharedPreferences.getInstance();
    const key = 'token';
    final value = prefs.get(key) ?? 0;
    var url = Uri.parse('${baseURL}pedidos/showto');
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
