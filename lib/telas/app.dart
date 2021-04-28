import 'package:flutter/material.dart';
import 'package:flutter_lista_compras/banco_de_dados/banco.dart';

class MenuApp extends StatefulWidget {
  static const routeName = 'MenuApp';

  @override
  _MenuAppState createState() => _MenuAppState();
}

class _MenuAppState extends State<MenuApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: buildListView(),
      ),
      appBar: AppBar(
        title: Text('Lista de compras'),
      ),
    );
  }

  dynamic retornarUserBD() async {
    var userData;
    SQLDatabase.read('users').then((value) => userData = value[]);
    return userData;
  }

  /// Lendo os valores do banco de dados
  ListView buildListView() {
    var userData = retornarUserBD();

    return ListView(
      padding: EdgeInsets.zero,
      children: [
        UserAccountsDrawerHeader(
          accountName: Text(userData['nome']),
          accountEmail: Text(userData['email']),
          currentAccountPicture: CircleAvatar(
            child: Text(getInitials(userData['nome'])),
          ),
        ),
        ListTile(
          leading: Icon(Icons.logout),
          title: Text('Sair'),
          onTap: () {
            SQLDatabase.insert('ultimo_login', {'user_id': -1});
            Navigator.pushReplacementNamed(context, 'Menu');
          },
        ),
      ],
    );
  }

  /// Pegar as iniciais de um nome
  /// Fonte: https://stackoverflow.com/questions/61289182/how-to-get-first-character-from-words-in-flutter-dart
  String getInitials(String name) => name.isNotEmpty
      ? name.trim().split(' ').map((l) => l[0].toUpperCase()).take(2).join()
      : '';
}
