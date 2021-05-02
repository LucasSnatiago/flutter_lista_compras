import 'package:flutter/material.dart';
import 'package:flutter_lista_compras/loading.dart';
import 'package:flutter_lista_compras/login/login.dart';
import 'package:flutter_lista_compras/login/registrar.dart';
import 'package:flutter_lista_compras/telas/MenuApp.dart';
import 'package:flutter_lista_compras/telas/NovoProduto.dart';
import 'package:flutter_lista_compras/telas/editarProduto.dart';
import 'package:flutter_lista_compras/telas/exibirProduto.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
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
        NovoProduto.routeName: (ctx) => NovoProduto(),
        ExibirProduto.routeName: (ctx) => ExibirProduto(),
        EditarProduto.routeName: (ctx) => EditarProduto(),
      },
      localizationsDelegates: [GlobalMaterialLocalizations.delegate],
      supportedLocales: [const Locale('pt')],
    );
  }
}
