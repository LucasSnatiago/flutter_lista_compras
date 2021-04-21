import 'package:flutter/material.dart';

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
    );
  }
}

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Compras'),
      ),
      body: SingleChildScrollView(
        child: Form(
          child: Column(
            children: [
              ElevatedButton(onPressed: () {}, child: Text('Entrar na conta')),
            ],
          ),
        ),
      ),
    );
  }
}
