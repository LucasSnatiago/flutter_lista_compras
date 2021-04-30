import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'banco_de_dados/banco.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Carregando dados'),
      ),
      body: FutureBuilder(
        future: _autologin(),
        builder:
            (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) =>
                snapshot.connectionState == ConnectionState.waiting
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : _login(context, snapshot.data),
      ),
    );
  }

  Widget _login(context, List<Map<String, dynamic>>? rows) {
    // Pegando o valor salvo do ultimo ID de usuário
    loadUserID().then((userID) {
      // Verificando se o banco de dados existe
      if (rows != null && rows.isNotEmpty) {
        // Descobrir qual o index do user a partir da id
        var user;
        for (int i = 0; i < rows.length; i++)
          if (rows[i]['id'] == userID) user = rows[i];

        print(user);
        // Testando os valores do banco
        if (user['esta_logado'] == 'true') {
          print('Usuário encontrado, logando usuário!');
          Future.delayed(
              Duration.zero,
              () => Navigator.pushReplacementNamed(context, 'MenuApp',
                  arguments: userID));
        } else {
          // Banco existe, mas o usuário não
          print('Usuário não encontrado, banco existe!');
          Future.delayed(Duration.zero,
              () => Navigator.pushReplacementNamed(context, 'Menu'));
        }
      } else {
        // Banco não existe, será criado ao criar a primeira conta
        print('Usuário não encontrado e banco não existe!');
        Future.delayed(Duration.zero,
            () => Navigator.pushReplacementNamed(context, 'Menu'));
      }
    });

    return Center(
      child: Text('Dados carregados!'),
    );
  }

  Future<List<Map<String, dynamic>>> _autologin() async {
    // Verificar se o usuario ja estava previamente logado
    // Verificando se já existe um banco de dados no celular
    var rows;
    try {
      rows = await SQLDatabase.read('ultimo_login');
    } catch (e) {
      print(e);
    }

    return rows;
  }

  saveUserID(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('user_id', id);
  }

  Future<int> loadUserID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('user_id') ?? -1;
  }
}
