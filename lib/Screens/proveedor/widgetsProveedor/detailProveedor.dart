import 'package:flutter/material.dart';
import 'package:torrico_import/Screens/proveedor/editProveedor.dart';
import 'package:torrico_import/Screens/proveedor/proveedor_screen.dart';
import 'package:torrico_import/services/proveedor_services.dart';

class Detail extends StatefulWidget {
  List list;
  int index;
  Detail({super.key, required this.index, required this.list});

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  void confirm() {
    AlertDialog alertDialog = AlertDialog(
      content: Text(
          "¿Está seguro de eliminar '${widget.list[widget.index]['nombreempresa']}'?"),
      actions: <Widget>[
        TextButton(
          child: Text(
            "OK, eliminar",
            style: TextStyle(color: Colors.black),
          ),
          onPressed: () {
            ProveedorServices()
                .removeProveedor(widget.list[widget.index]['id'].toString());
            Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => Proveedor(),
            ));
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.red),
          ),
        ),
        TextButton(
          child: Text(
            "CANCELAR",
            style: TextStyle(color: Colors.black),
          ),
          onPressed: () => Navigator.pop(context),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.green),
          ),
        ),
      ],
    );

    showDialog(context: context, builder: (context) => alertDialog);
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Detalle del Proveedor",
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
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        padding: const EdgeInsets.all(50.0),
        child: SizedBox(
          width: 800,
          height: 1500,
          child: Card(
            child: Center(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 100.0),
                  ),
                  Text(
                    "nombre de la empresa:${widget.list[widget.index]['nombreempresa']}",
                    style: TextStyle(fontSize: 20.0),
                  ),
                  SizedBox(height: 30.0),
                  Text(
                    "Razon social : ${widget.list[widget.index]['razonsocial']}",
                    style: TextStyle(fontSize: 18.0),
                  ),
                  SizedBox(height: 30.0),
                  Text(
                    "Nombre del Proveedor : ${widget.list[widget.index]['nombreproveedor']}",
                    style: TextStyle(fontSize: 18.0),
                  ),
                  SizedBox(height: 30.0),
                  Text(
                    "Numero de Contacto : ${widget.list[widget.index]['numcontacto']}",
                    style: TextStyle(fontSize: 18.0),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 50.0),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ElevatedButton(
                        child: Text("Editar"),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blueAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                        onPressed: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) => editProveedor(
                              list: widget.list,
                              index: widget.index,
                            ),
                          ),
                        ),
                      ),
                      VerticalDivider(),
                      ElevatedButton(
                        child: const Text("Eliminar"),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.redAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                        onPressed: () => confirm(),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
