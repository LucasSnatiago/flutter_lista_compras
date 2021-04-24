import 'package:flutter/material.dart';
import 'package:flutter_lista_compras/banco_de_dados/banco.dart';
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
        key: _globalKey,
        child: Form(
            child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              Text('Criar sua conta:'),
              Text(''),
              _buildTextFormField(
                  'username',
                  4,
                  'Digite um nome com mais de 3 caracteres!',
                  false,
                  'Nome de usuário'),
              SizedBox(
                height: 1,
              ),
              TextFormField(
                key: ValueKey('email'),
                keyboardType: TextInputType.emailAddress,
                enableSuggestions: false,
                initialValue: _formValues['email'],
                decoration: InputDecoration(
                    labelText: 'Email', border: OutlineInputBorder()),
                validator: (value) {
                  if (value == null || !isValidEmail(value))
                    return 'O email precisa ser válido!';
                  return null;
                },
                onSaved: (value) {
                  _formValues['email'] = value;
                },
              ),
              SizedBox(
                height: 1,
              ),
              _buildTextFormField('password', 8,
                  'A senha precisa ter no mínimo 8 caracteres', true, 'Senha'),
              SizedBox(
                height: 1,
              ),
              TextFormField(
                key: ValueKey('confirm_password'),
                enableSuggestions: false,
                initialValue: _formValues['confirm_password'],
                obscureText: true,
                decoration: InputDecoration(
                    labelText: 'Repita a senha', border: OutlineInputBorder()),
                validator: (value) {
                  if (value == null || _formValues['password'] != value)
                    return 'As duas senhas precisam coincidir!';
                  return null;
                },
                onSaved: (value) {
                  _formValues['confirm_password'] = value;
                },
              ),
              ElevatedButton(
                  onPressed: _registrar, child: Text('Registrar-se')),
            ],
          ),
        )),
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
      validator: (value) {
        if (value == null || value.length < valueLength) {
          return valueLengthError;
        }
        return '';
      },
      obscureText: isPassword,
      onSaved: (value) => _formValues[valueKey] = value,
      decoration:
          InputDecoration(labelText: labelText, border: OutlineInputBorder()),
    );
  }

  _registrar() {
    if (_globalKey.currentState?.validate() ?? false) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Há erro em algum dos campos!')));

      return;
    }

    _globalKey.currentState?.save();
    // Verificar a senhas
    print(_formValues);

    // Fazendo o hash da senha
    //_formValues['password'] = hashedPassword(_formValues['password']);
    // Inserindo no banco de dados
    SQLDatabase.insert('users', _formValues).then((id) {
      if (id < 0) {
        var newLoggedUser = {
          'user_id': id,
        };

        SQLDatabase.insert('ultimo_login', newLoggedUser);
        Navigator.of(context).pushNamed('MenuApp');
      }
    });
  }
}
