import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:torrico_import/services/globals.dart';

class ProvedoorServices {
  var status;

  var token;
  //a;adir producto
  void addProveedor(String _nombreempresa, String _razonsocial,
      String _nombreproveedor, int _numcontacto) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;

    var url = Uri.parse(baseURL + 'proveedor/store');
    final response = await http.post(url, headers: {
      'Accept': 'application/json'
    }, body: {
      "nombreempresa": "$_nombreempresa",
      'razonsocial': "$_razonsocial",
      'nombreproveedor': "$_nombreproveedor",
      "numcontacto": "$_numcontacto"
    });
    status = response.body.contains('error');

    var data = json.decode(response.body);

    if (status) {
      print('data : ${data["error"]}');
    } else {
      print('data : ${data["token"]}');
      _save(data["token"]);
    }
  }

  void editProveedor(String id, String _nombreempresa, String _razonsocial,
      String _nombreproveedor, int _numcontacto) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;
    var url = Uri.parse(baseURL + 'proveedor/update/$id');
    http.put(url, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $value'
    }, body: {
      "nombreempresa": "$_nombreempresa",
      'razonsocial': "$_razonsocial",
      'nombreproveedor': "$_nombreproveedor",
      "numcontacto": "$_numcontacto"
    }).then((response) {
      print('Response status : ${response.statusCode}');
      print('Response body : ${response.body}');
    });
  }

  void removeProveedor(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;
    var url = Uri.parse(baseURL + 'proveedor/destroy/$id');

    http.delete(url, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $value'
    }).then((response) {
      print('Response status : ${response.statusCode}');
      print('Response body : ${response.body}');
    });
  }

  Future<List> getData() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;

    var url = Uri.parse(baseURL + 'proveedor/showto');

    http.Response response = await http.get(url, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $value'
    });
    return json.decode(response.body);
  }

  _save(String token) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = token;
    prefs.setString(key, value);
  }

  read() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;
    print('read : $value');
  }
}
