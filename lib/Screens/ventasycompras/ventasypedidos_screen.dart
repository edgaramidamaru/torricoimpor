import 'package:flutter/material.dart';
import 'package:torrico_import/Screens/ventasycompras/pedidos/pedidos_screen.dart';
import 'package:torrico_import/Screens/ventasycompras/ventas/ventas_screen.dart';

class VentasScreen extends StatefulWidget {
  const VentasScreen({super.key});

  @override
  State<VentasScreen> createState() => _VentasScreenState();
}

class _VentasScreenState extends State<VentasScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => const Ventas(),
                        ));
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromRGBO(3, 37, 140, 1),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.shopping_cart,
                        size: 64,
                        color: Colors.white,
                      ),
                      SizedBox(height: 8), // Espacio entre el icono y el texto
                      Text(
                        'Realizar Venta',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 90),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => const Pedidos(),
                          ));
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromRGBO(3, 37, 140, 1),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.assignment_add,
                          size: 64,
                          color: Colors.white,
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Realizar Pedido',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                          ),
                        ),
                      ],
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
