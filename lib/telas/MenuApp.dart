import 'package:flutter/material.dart';
import 'package:flutter_lista_compras/banco_de_dados/banco.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  Future<Map<String, dynamic>> retornarUserBD() async {
    var userData;

    final prefs = await SharedPreferences.getInstance();
    final rows = await SQLDatabase.read('users');

    int id = prefs.getInt('user_id') ?? -1;
    if (id < 0) return {};
    userData = rows[id - 1];
    print('Data: ' + userData.toString());
    return userData;
  }

  /// Lendo os valores do banco de dados
  Widget buildListView() {
    return FutureBuilder(
        future: retornarUserBD(),
        builder: (context, AsyncSnapshot<Map> userData) =>
            userData.connectionState == ConnectionState.waiting
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      UserAccountsDrawerHeader(
                        accountName: Text(userData.data!['nome']),
                        accountEmail: Text(userData.data!['email']),
                        currentAccountPicture: CircleAvatar(
                          child: Text(getInitials(userData.data!['nome'])),
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
                  ));
  }

  /// Pegar as iniciais de um nome
  /// Fonte: https://stackoverflow.com/questions/61289182/how-to-get-first-character-from-words-in-flutter-dart
  String getInitials(String name) => name.isNotEmpty
      ? name.trim().split(' ').map((l) => l[0].toUpperCase()).take(2).join()
      : '';
}
