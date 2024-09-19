import 'package:flutter/material.dart';
import 'package:torrico_import/Screens/cliente/editCliente.dart';
import 'package:torrico_import/Screens/homepage_screen.dart';
import 'package:torrico_import/services/cliente_services.dart';

class DetailCliente extends StatefulWidget {
  List list;
  int index;
  DetailCliente({super.key, required this.index, required this.list});

  @override
  State<DetailCliente> createState() => _DetailClienteState();
}

class _DetailClienteState extends State<DetailCliente> {
  void confirm() {
    AlertDialog alertDialog = AlertDialog(
      content: Text(
          "¿Está seguro de eliminar '${widget.list[widget.index]['nombrecomcliente']}'?"),
      actions: <Widget>[
        TextButton(
          child: Text(
            "Ok,eliminar",
            style: TextStyle(color: Colors.black),
          ),
          onPressed: () {
            ClienteServices()
                .removeCliente(widget.list[widget.index]['id'].toString());
            Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => HomePage(),
            ));
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.red),
          ),
        ),
        TextButton(
          child: Text(
            "Cancelar",
            style: TextStyle(color: Colors.black),
          ),
          onPressed: () => Navigator.pop(context),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.green),
          ),
        )
      ],
    );
    showDialog(context: context, builder: (context) => alertDialog);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Detalle del Cliente",
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
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
        padding: EdgeInsets.all(50.0),
        child: SizedBox(
            width: 800,
            height: 1500,
            child: Card(
                child: Center(
                    child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 100.0),
                ),
                Text(
                  "nombre completo del cliente: ${widget.list[widget.index]['nombrecomcliente']}",
                  style: TextStyle(fontSize: 20.0),
                ),
                SizedBox(height: 30.0),
                Text(
                  "Numero de Carnet: ${widget.list[widget.index]['carnet']}",
                  style: TextStyle(fontSize: 20.0),
                ),
                SizedBox(height: 30.0),
                Text(
                  "Numero de Celular: ${widget.list[widget.index]['celular']}",
                  style: TextStyle(fontSize: 20.0),
                ),
                SizedBox(height: 30.0),
                Text(
                  "Direccion: ${widget.list[widget.index]['direccion']}",
                  style: TextStyle(fontSize: 20.0),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 50.0),
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
                          builder: (BuildContext context) => editCliente(
                            list: widget.list,
                            index: widget.index,
                          ),
                        ),
                      ),
                    ),
                    VerticalDivider(),
                    ElevatedButton(
                      child: Text("Eliminar"),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.redAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      onPressed: () => confirm(),
                    )
                  ],
                )
              ],
            )))),
      ),
    );
  }
}
