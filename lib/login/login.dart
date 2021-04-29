import 'package:flutter/material.dart';
import 'package:flutter_lista_compras/banco_de_dados/banco.dart';
import 'package:flutter_lista_compras/login/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Menu extends StatefulWidget {
  static const routeName = 'Menu';

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  final _globalKey = GlobalKey<FormState>();

  var _formValues = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Entre na sua conta'),
      ),
      body: SingleChildScrollView(
        child: Form(
            key: _globalKey,
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Entre com sua conta: '),
                  Text(''),
                  TextFormField(
                    key: ValueKey('email'),
                    keyboardType: TextInputType.emailAddress,
                    autocorrect: false,
                    initialValue: _formValues['email'],
                    validator: (value) {
                      if (value == null || value.length < 4) {
                        return 'Digite um email válido!';
                      }
                      return '';
                    },
                    onSaved: (value) => _formValues['email'] = value,
                    decoration: InputDecoration(
                        labelText: 'Email', border: OutlineInputBorder()),
                  ),
                  SizedBox(
                    height: 1,
                  ),
                  TextFormField(
                    key: ValueKey('password'),
                    autocorrect: false,
                    initialValue: _formValues['password'],
                    validator: (value) {
                      if (value == null || value.length < 8) {
                        return 'Você precisa digitar uma senha com pelo menos 8 caracteres!';
                      }
                      return '';
                    },
                    obscureText: true,
                    onSaved: (value) => _formValues['password'] = value,
                    decoration: InputDecoration(
                        labelText: 'Senha', border: OutlineInputBorder()),
                  ),
                  SizedBox(
                    height: 1,
                  ),
                  ElevatedButton(onPressed: _login, child: Text('Login')),
                  TextButton(
                      onPressed: () =>
                          Navigator.of(context).pushNamed('Registrar'),
                      child: Text('Registrar-se'))
                ],
              ),
            )),
      ),
    );
  }

  // Tentar localizar a chave de login do usuário no sistema e logar ele
  _login() {
    _globalKey.currentState?.save();

    if (_globalKey.currentState?.validate() ?? false) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Há erro em algum dos campos!')));

      return;
    }

    // Verificar se existe a pessoa no banco de dados
    var usuarioEncontrado = false;
    var usuarioID = 0;
    SQLDatabase.read('users').then((rows) {
      for (int i = 0; i < rows.length; i++) {
        if (rows[i]['email'] == _formValues['email'] &&
            checkPassword(_formValues['password'], rows[i]['senha'])) {
          usuarioEncontrado = true;
          usuarioID = rows[i]['id'];
          i = rows.length;
        }
      }

      print(rows);

      // Logando usuário encontrado
      var ultimLogin = {'user_id': usuarioID, 'esta_logado': 'true'};

      if (usuarioEncontrado) {
        saveUserID(usuarioID);
        SQLDatabase.update('ultimo_login', ultimLogin)
            .then((value) => Navigator.of(context).pushNamed('MenuApp'));
      } else {
        // Usuário não foi encontrado no banco
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Usuário não encontrado!')));
      }
    });
  }

  saveUserID(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('user_id', id);
  }
}
