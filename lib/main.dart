import 'package:flutter/material.dart';
import 'package:flutter_lista_compras/telas/login.dart';
import 'package:flutter_lista_compras/telas/registrar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de Compras',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: Menu(),
      routes: {
        Registrar.routeName: (ctx) => Registrar(),
      },
    );
  }
}
