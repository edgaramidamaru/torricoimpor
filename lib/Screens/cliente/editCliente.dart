import 'package:flutter/material.dart';
import 'package:torrico_import/Screens/homepage_screen.dart';
import 'package:torrico_import/rounded_button.dart';
import 'package:torrico_import/services/cliente_services.dart';

class editCliente extends StatefulWidget {
  final List list;
  final int index;
  const editCliente({super.key, required this.list, required this.index});

  @override
  State<editCliente> createState() => _editClienteState();
}

class _editClienteState extends State<editCliente> {
  late TextEditingController controllernombrecomcliente;
  late TextEditingController controllercarnet;
  late TextEditingController controllercelular;
  late TextEditingController controllerdireccion;
  @override
  void initState() {
    var controllerId =
        TextEditingController(text: widget.list[widget.index]['id'].toString());
    controllernombrecomcliente = TextEditingController(
        text: widget.list[widget.index]['nombrecomcliente'].toString());
    controllercarnet = TextEditingController(
        text: widget.list[widget.index]['carnet'].toString());
    controllercelular = TextEditingController(
        text: widget.list[widget.index]['celular'].toString());
    controllerdireccion = TextEditingController(
        text: widget.list[widget.index]['direccion'].toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'EDITAR CLIENTE',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        backgroundColor: Color.fromRGBO(3, 37, 140, 1),
        iconTheme: IconThemeData(color: Colors.white),
        toolbarHeight: 80,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Form(
          child: ListView(
            padding: EdgeInsets.all(10.0),
            children: <Widget>[
              Column(
                children: <Widget>[
                  ListTile(
                    title: TextFormField(
                      controller: controllernombrecomcliente,
                      validator: (value) {
                        if (value!.isEmpty)
                          return "ingrese nombre del cliente ";
                      },
                      decoration: InputDecoration(
                        hintText: "Nombre del cliente",
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                  ),
                  ListTile(
                    title: TextFormField(
                      controller: controllercarnet,
                      validator: (value) {
                        if (value!.isEmpty) return "ingrese numeto del carnet";
                      },
                      decoration: InputDecoration(
                        hintText: "Numero del carnet",
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                  ),
                  ListTile(
                    title: TextFormField(
                      controller: controllercelular,
                      validator: (value) {
                        if (value!.isEmpty) return "ingrese numero de celular";
                      },
                      decoration: InputDecoration(
                        hintText: "Numero de celular",
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                  ),
                  ListTile(
                    title: TextFormField(
                      controller: controllerdireccion,
                      validator: (value) {
                        if (value!.isEmpty)
                          return "ingrese direccion del cliente ";
                      },
                      decoration: InputDecoration(
                        hintText: "direccion del cliente",
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                  ),
                  Divider(
                    height: 1.0,
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                  ),
                  RoundedButton(
                    btntext: "Editar",
                    onBtnPressed: () {
                      editClient();
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => HomePage()));
                    },
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void editClient() async {
    String id = widget.list[widget.index]['id'].toString();
    String nombrecomcliente = controllernombrecomcliente.text;
    String carnet = controllercarnet.text;
    int celular = int.parse(controllercelular.text);
    String direccion = controllerdireccion.text;
    ClienteServices clienteServices = ClienteServices();
    clienteServices.editCliente(
      id,
      nombrecomcliente,
      carnet,
      celular,
      direccion,
    );
  }
}
