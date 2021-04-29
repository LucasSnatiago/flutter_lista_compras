import 'package:flutter/material.dart';
import 'package:flutter_lista_compras/loading.dart';
import 'package:flutter_lista_compras/login/login.dart';
import 'package:flutter_lista_compras/login/registrar.dart';
import 'package:flutter_lista_compras/telas/MenuApp.dart';

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
        Menu.routeName: (ctx) => Menu(),
        MenuApp.routeName: (ctx) => MenuApp(),
      },
    );
  }
}
