import 'package:flutter/material.dart';

class moduleOrders extends StatefulWidget {
  const moduleOrders({Key? key}) : super(key: key);

  @override
  _moduleOrdersState createState() => _moduleOrdersState();
}

class _moduleOrdersState extends State<moduleOrders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Card(
            child: ListTile(
                leading: Icon(Icons.album),
                title: Text('Pedidos'),
                subtitle: Text('Getion de Pedidos')),
          ),
          Card(
            child: ListTile(
                leading: Icon(Icons.album),
                title: Text('Cotizaciones'),
                subtitle: Text('Getion de Cotizaciones')),
          ),
        ],
      ),
    );
  }
}
