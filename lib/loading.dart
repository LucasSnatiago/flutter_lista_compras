import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
        var userId = rows[rows.length - 1]['user_id'];
        if (userId != -1) {
          Navigator.pushReplacementNamed(context, 'MenuApp');
          saveUserID(userId);
        }

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

  saveUserID(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('user_id', id);
  }
}
