import 'package:flutter/material.dart';

class MenuApp extends StatefulWidget {
  static const routeName = 'MenuApp';

  @override
  _MenuAppState createState() => _MenuAppState();
}

class _MenuAppState extends State<MenuApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de compras'),
      ),
    );
  }
}
