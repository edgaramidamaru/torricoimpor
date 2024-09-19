import 'package:flutter/material.dart';
import 'package:torrico_import/Screens/homepage_screen.dart';
import 'package:torrico_import/rounded_button.dart';
import 'package:torrico_import/services/producto_services.dart';

class editProducto extends StatefulWidget {
  final List list;
  final int index;
  const editProducto({super.key, required this.list, required this.index});

  @override
  State<editProducto> createState() => _editProductoState();
}

class _editProductoState extends State<editProducto> {
  late TextEditingController controllernombreproducto;
  late TextEditingController controllerdescripcion;
  late TextEditingController controllerunidad;
  late TextEditingController controllerexistencia;
  late TextEditingController controllercosto;
  @override
  void initState() {
    var controllerid =
        TextEditingController(text: widget.list[widget.index]['id'].toString());
    controllernombreproducto = TextEditingController(
        text: widget.list[widget.index]['nombreproducto'].toString());
    controllerdescripcion = TextEditingController(
        text: widget.list[widget.index]['descripcion'].toString());
    controllerunidad = TextEditingController(
        text: widget.list[widget.index]['unidad'].toString());
    controllerexistencia = TextEditingController(
        text: widget.list[widget.index]['existencia'].toString());
    controllercosto = TextEditingController(
        text: widget.list[widget.index]['costo'].toString());
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
                      controller: controllernombreproducto,
                      validator: (value) {
                        if (value!.isEmpty)
                          return "ingrese nombre del producto";
                      },
                      decoration: InputDecoration(
                        hintText: "Nombre del producto",
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                  ),
                  ListTile(
                    title: TextFormField(
                      controller: controllerdescripcion,
                      validator: (value) {
                        if (value!.isEmpty)
                          return "ingrese descripcion del producto";
                      },
                      decoration: InputDecoration(
                        hintText: "Descripcion del producto",
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                  ),
                  ListTile(
                    title: TextFormField(
                      controller: controllerunidad,
                      validator: (value) {
                        if (value!.isEmpty) return "ingrese unidad";
                      },
                      decoration: InputDecoration(
                        hintText: "unidad",
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                  ),
                  ListTile(
                    title: TextFormField(
                      controller: controllerexistencia,
                      validator: (value) {
                        if (value!.isEmpty)
                          return "ingrese existencia del producto";
                      },
                      decoration: InputDecoration(
                        hintText: "Existencia",
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                  ),
                  ListTile(
                    title: TextFormField(
                      controller: controllercosto,
                      validator: (value) {
                        if (value!.isEmpty) return "ingrese costo del producto";
                      },
                      decoration: InputDecoration(
                        hintText: "Costo",
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
                        editProduct();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomePage()));
                      })
                ],
              )
            ],
          )),
        ));
  }

  void editProduct() async {
    String id = widget.list[widget.index]['id'].toString();
    String nombreproducto = controllernombreproducto.text;
    String descripcion = controllerdescripcion.text;
    String unidad = controllerunidad.text;
    int existencia = int.parse(controllerexistencia.text);
    int costo = int.parse(controllercosto.text);
    ProductoServices productoServices = ProductoServices();
    productoServices.editProducto(
      id,
      nombreproducto,
      descripcion,
      unidad,
      existencia,
      costo,
    );
  }
}
