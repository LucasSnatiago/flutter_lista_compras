import 'package:flutter/material.dart';
import 'package:flutter_lista_compras/loading.dart';
import 'package:flutter_lista_compras/login/registrar.dart';
import 'package:flutter_lista_compras/telas/app.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de Compras',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: Loading(),
      routes: {
        Registrar.routeName: (ctx) => Registrar(),
        MenuApp.routeName: (ctx) => MenuApp(),
      },
    );
  }
}
