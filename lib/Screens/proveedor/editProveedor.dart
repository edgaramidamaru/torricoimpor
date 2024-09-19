import 'package:flutter/material.dart';
import 'package:torrico_import/Screens/proveedor/proveedor_screen.dart';
import 'package:torrico_import/rounded_button.dart';
import 'package:torrico_import/services/proveedor_services.dart';

class editProveedor extends StatefulWidget {
  final List list;
  final int index;
  const editProveedor({super.key, required this.list, required this.index});

  @override
  State<editProveedor> createState() => _editProveedorState();
}

class _editProveedorState extends State<editProveedor> {
  late TextEditingController controllernombreempresa;
  late TextEditingController controllerrazonsocial;
  late TextEditingController controllernombreproveedor;
  late TextEditingController controllernumcontacto;
  @override
  void initState() {
    var controllerId =
        TextEditingController(text: widget.list[widget.index]['id'].toString());
    controllernombreempresa = TextEditingController(
        text: widget.list[widget.index]['nombreempresa'].toString());
    controllerrazonsocial = TextEditingController(
        text: widget.list[widget.index]['razonsocial'].toString());
    controllernombreproveedor = TextEditingController(
        text: widget.list[widget.index]['nombreproveedor'].toString());
    controllernumcontacto = TextEditingController(
        text: widget.list[widget.index]['numcontacto'].toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'EDITAR PROVEEDOR',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        backgroundColor: const Color.fromRGBO(3, 37, 140, 1),
        iconTheme: const IconThemeData(color: Colors.white),
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
                      controller: controllernombreempresa,
                      validator: (value) {
                        if (value!.isEmpty)
                          return "ingrese nombre de la empresa";
                      },
                      decoration: InputDecoration(
                        hintText: "Nombre de la empresa",
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                  ),
                  ListTile(
                    title: TextFormField(
                      controller: controllerrazonsocial,
                      validator: (value) {
                        if (value!.isEmpty) return "ingrese razon social";
                      },
                      decoration: InputDecoration(
                        hintText: "Nombre de la razon social",
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                  ),
                  ListTile(
                    title: TextFormField(
                      controller: controllernombreproveedor,
                      validator: (value) {
                        if (value!.isEmpty)
                          return "ingrese nombre del proveedor";
                      },
                      decoration: InputDecoration(
                        hintText: "Nombre del proveedor",
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                  ),
                  ListTile(
                    title: TextFormField(
                      controller: controllernumcontacto,
                      validator: (value) {
                        if (value!.isEmpty) return "ingrese numero de contacto";
                      },
                      decoration: InputDecoration(
                        hintText: "Numero de contacto",
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
                      editProvider();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Proveedor()));
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

  void editProvider() async {
    String id = widget.list[widget.index]['id'].toString();
    String nombreempresa = controllernombreempresa.text;
    String razonsocial = controllerrazonsocial.text;
    String nombreproveedor = controllernombreproveedor.text;
    int numcontacto = int.parse(controllernumcontacto.text);

    ProveedorServices provedoorServices = ProveedorServices();
    provedoorServices.editProveedor(
      id,
      nombreempresa,
      razonsocial,
      nombreproveedor,
      numcontacto,
    );
  }
}
