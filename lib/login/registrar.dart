import 'package:flutter/material.dart';
import 'package:flutter_lista_compras/banco_de_dados/banco.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'utils.dart';

class Registrar extends StatefulWidget {
  static const routeName = 'Registrar';

  @override
  _RegistrarState createState() => _RegistrarState();
}

class _RegistrarState extends State<Registrar> {
  final _globalKey = GlobalKey<FormState>();
  Map<String, dynamic> _formValues = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registre-se'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _globalKey,
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('Criar sua conta:'),
                SizedBox(
                  height: 10,
                ),
                _buildTextFormField(
                    'username',
                    4,
                    'Digite um nome com mais de 3 caracteres!',
                    false,
                    'Nome de usuário'),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  key: ValueKey('email'),
                  keyboardType: TextInputType.emailAddress,
                  enableSuggestions: false,
                  initialValue: _formValues['email'],
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => (value == null || !isValidEmail(value))
                      ? 'O email precisa ser válido!'
                      : null,
                  onSaved: (value) {
                    _formValues['email'] = value;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                _buildTextFormField(
                    'password',
                    8,
                    'A senha precisa ter no mínimo 8 caracteres',
                    true,
                    'Senha'),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  key: ValueKey('confirm_password'),
                  enableSuggestions: false,
                  initialValue: _formValues['confirm_password'],
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Repita a senha',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) =>
                      (value == null || _formValues['password'] != value)
                          ? 'As duas senhas precisam coincidir!'
                          : null,
                  onSaved: (value) {
                    _formValues['confirm_password'] = value;
                  },
                ),
                SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  onPressed: _registrar,
                  child: Text('Registrar-se'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextFormField _buildTextFormField(
    valueKey,
    valueLength,
    valueLengthError,
    isPassword,
    labelText,
  ) {
    return TextFormField(
      key: ValueKey(valueKey),
      autocorrect: false,
      initialValue: _formValues[valueKey],
      validator: (value) => (value == null || value.length < valueLength)
          ? valueLengthError
          : null,
      obscureText: isPassword,
      onSaved: (value) => _formValues[valueKey] = value,
      decoration:
          InputDecoration(labelText: labelText, border: OutlineInputBorder(),),
    );
  }

  _registrar() {
    _globalKey.currentState?.save();

    if (_globalKey.currentState?.validate() ?? false) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Há erro em algum dos campos!'),
        ),
      );

      return;
    }

    // Fazendo o hash da senha
    var hPassword = hashedPassword(_formValues['password']);
    // Inserindo no banco de dados
    var insertUser = {
      'nome': _formValues['username'],
      'email': _formValues['email'],
      'senha': hPassword
    };
    SQLDatabase.insert('users', insertUser).then((id) {
      // Copiar os itens para o banco de dados
      var userLogged = {
        'user_id': id,
      };

      SQLDatabase.insert('ultimo_login', userLogged);
      saveUserID(id);
      Navigator.of(context).pushNamed('MenuApp');
    });
  }

  saveUserID(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('user_id', id);
  }
}
