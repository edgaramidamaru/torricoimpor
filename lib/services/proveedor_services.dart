import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:torrico_import/services/globals.dart';

class ProveedorServices {
  var status;

  var token;

  Future<void> addProveedor(String nombreempresa, String razonsocial,
      String nombreproveedor, int numcontacto) async {
    try {
      var url = Uri.parse('${baseURL}proveedor/store');
      final response = await http.post(
        url,
        headers: {
          'Accept': 'application/json',
        },
        body: {
          'nombreempresa': nombreempresa,
          'razonsocial': razonsocial,
          'nombreproveedor': nombreproveedor,
          'numcontacto': numcontacto.toString()
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print('Proveedor creado exitosamente');
      } else {
        print('Error al crear proveedor: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  void editProveedor(String id, String nombreempresa, String razonsocial,
      String nombreproveedor, int numcontacto) async {
    final prefs = await SharedPreferences.getInstance();
    const key = 'token';
    final value = prefs.get(key) ?? 0;
    var url = Uri.parse('${baseURL}proveedor/update/$id');
    http.put(url, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $value'
    }, body: {
      "nombreempresa": nombreempresa,
      'razonsocial': razonsocial,
      'nombreproveedor': nombreproveedor,
      "numcontacto": "$numcontacto"
    }).then((response) {
      print('Response status : ${response.statusCode}');
      print('Response body : ${response.body}');
    });
  }

  void removeProveedor(String id) async {
    final prefs = await SharedPreferences.getInstance();
    const key = 'token';
    final value = prefs.get(key) ?? 0;
    var url = Uri.parse('${baseURL}proveedor/destroy/$id');

    http.delete(url, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $value'
    }).then((response) {
      print('Response status : ${response.statusCode}');
      print('Response body : ${response.body}');
    });
  }

  Future<List<Map<String, dynamic>>> getData() async {
    final prefs = await SharedPreferences.getInstance();
    const key = 'token';
    final value = prefs.get(key) ?? 0;

    var url = Uri.parse('${baseURL}proveedor/showto');

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
