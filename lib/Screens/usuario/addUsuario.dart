import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:torrico_import/Screens/usuario/usuarios_screen.dart';
import 'package:torrico_import/rounded_button.dart';
import 'package:torrico_import/services/auth_services.dart';
import 'package:torrico_import/services/globals.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String _nombrecompleto = '';
  String _name = '';
  String _email = '';
  String _password = '';
  String _cargo = '';
  crearUsuario() async {
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(_email);
    if (emailValid) {
      http.Response response = await AuthServices.register(
          _nombrecompleto, _name, _email, _password, _cargo);
      Map responseMap = jsonDecode(response.body);
      if (response.statusCode == 200) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => const Usuarios(),
            ));
      } else {
        errorSnackBar(context, responseMap.values.first[0]);
      }
    } else {
      errorSnackBar(context, 'correo no valido');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'REGISTRAR USUARIO',
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
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets/images/background.png'), // Ruta de la imagen de fondo
            fit: BoxFit
                .cover, // Ajustar la imagen para cubrir toda el área disponible
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(height: 20),
              Container(
                color: Colors.white, // Color de fondo blanco
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'nombre completo',
                  ),
                  onChanged: (value) {
                    _nombrecompleto = value;
                  },
                ),
              ),
              SizedBox(height: 30),
              Container(
                color: Colors.white, // Color de fondo blanco
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'nombre de usuario',
                  ),
                  onChanged: (value) {
                    _name = value;
                  },
                ),
              ),
              SizedBox(height: 30),
              Container(
                color: Colors.white, // Color de fondo blanco
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Correo electrónico',
                  ),
                  onChanged: (value) {
                    _email = value;
                  },
                ),
              ),
              SizedBox(height: 30),
              Container(
                color: Colors.white, // Color de fondo blanco
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Contraseña',
                  ),
                  onChanged: (value) {
                    _password = value;
                  },
                ),
              ),
              SizedBox(height: 30),
              Container(
                color: Colors.white, // Color de fondo blanco
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'cargo',
                  ),
                  onChanged: (value) {
                    _cargo = value;
                  },
                ),
              ),
              SizedBox(
                height: 40,
              ),
              RoundedButton(
                btntext: 'Crear cuenta',
                onBtnPressed: () => crearUsuario(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
