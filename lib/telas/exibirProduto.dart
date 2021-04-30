import 'package:flutter/material.dart';

class ListarContasUsuario extends StatelessWidget {
  String titulo;

  ListarContasUsuario(this.titulo);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed(''),
      child: ListTile(
        leading: CircleAvatar(),
        title: Text(titulo),
      ),
    );
  }
}
