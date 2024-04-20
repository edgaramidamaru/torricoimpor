import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:torrico_import/services/globals.dart';

class AuthServices {
  static Future<http.Response> login(String name, String password) async {
    Map data = {
      "name": name,
      "password": password,
    };
    var body = json.encode(data);
    var url = Uri.parse(baseURL + 'auth/login');
    http.Response response = await http.post(
      url,
      headers: headers,
      body: body,
    );
    print(response.body);
    return response;
  }

  static Future<http.Response> register(String nombrecompleto, String name,
      String email, String password, String cargo) async {
    Map data = {
      "nombrecompleto": nombrecompleto,
      "name": name,
      "email": email,
      "password": password,
      "cargo": cargo,
    };
    var body = json.encode(data);
    var url = Uri.parse(baseURL + 'auth/register');
    http.Response response = await http.post(
      url,
      headers: headers,
      body: body,
    );
    print(response.body);
    return response;
  }

  static Future<List<dynamic>> getUsers() async {
    var url = Uri.parse(baseURL + 'auth/showto');
    http.Response response = await http.get(
      url,
      headers: headers,
    );
    List<dynamic> users = json.decode(response.body);
    return users;
  }

  static Future<http.Response> updateUser(
      String userId, Map<String, dynamic> updatedData) async {
    var url = Uri.parse(baseURL + 'auth/user/$userId');
    var body = json.encode(updatedData);
    http.Response response = await http.put(
      url,
      headers: headers,
      body: body,
    );
    return response;
  }

  static Future<http.Response> deleteUser(String userId) async {
    var url = Uri.parse(baseURL + 'auth/user/$userId');
    http.Response response = await http.delete(
      url,
      headers: headers,
    );
    return response;
  }
}
