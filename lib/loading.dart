import 'package:flutter/material.dart';
import 'package:flutter_lista_compras/telas/app.dart';
import 'banco_de_dados/banco.dart';
import 'login/login.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Carregando dados'),
      ),
      body: _autologin(context),
    );
  }

  Widget? _autologin(context) {
    // Verificar se o usuario ja estava previamente logado
    // Verificando se já existe um banco de dados no celular
    try {
      SQLDatabase.read('ultimo_login').then((rows) {
        print(rows);
        if (rows[rows.length - 1]['user_id'] != -1)
          Navigator.pushReplacementNamed(context, 'MenuApp');

        // Se o banco já existir e tiver um usuario nele logue esse usuário
        print('Nenhum user logado');
        Navigator.pushReplacementNamed(context, 'Menu');
      });
    } catch (e) {
      print('Deu catch');
      Navigator.pushReplacementNamed(context, 'Menu');
    }

    return Menu();
  }
}
