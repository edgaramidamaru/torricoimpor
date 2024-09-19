import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:torrico_import/services/globals.dart';

class ClienteServices {
  var status;
  var token;
  Future<void> addCliente(String nombrecomcliente, String carnet, int celular,
      String direccion) async {
    try {
      var url = Uri.parse('${baseURL}cliente/store');
      final response = await http.post(
        url,
        headers: {
          'Accept': 'application/json',
        },
        body: {
          'nombrecomcliente': nombrecomcliente,
          'carnet': carnet,
          'celular': celular.toString(),
          'direccion': direccion
        },
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print('Cliente creado con exito');
      } else {
        print('Error al crear cliente:${response.body}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  void editCliente(String id, String nombrecomcliente, String carnet,
      int celular, String direccion) async {
    final prefs = await SharedPreferences.getInstance();
    const key = 'token';
    final value = prefs.get(key) ?? 0;
    var url = Uri.parse('${baseURL}cliente/update/$id');
    http.put(url, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $value'
    }, body: {
      "nombrecomcliente": nombrecomcliente,
      "carnet": carnet,
      "celular": "$celular",
      "direccion": direccion
    }).then((response) {
      print('Response status:${response.statusCode}');
      print('Response body:${response.body}');
    });
  }

  void removeCliente(String id) async {
    final prefs = await SharedPreferences.getInstance();
    const key = 'token';
    final value = prefs.get(key) ?? 0;
    var url = Uri.parse('${baseURL}cliente/destroy/$id');

    http.delete(url, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $value'
    }).then((response) {
      print('Response status : ${response.statusCode}');
      print('Response body : ${response.body}');
    });
  }

  Future<List<Map<String, dynamic>>> getDataCliente() async {
    final prefs = await SharedPreferences.getInstance();
    const key = 'token';
    final value = prefs.get(key) ?? 0;

    var url = Uri.parse('${baseURL}cliente/showto');

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
