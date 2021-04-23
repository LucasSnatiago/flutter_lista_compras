import 'package:flutter/material.dart';

class Registrar extends StatefulWidget {
  static const routeName = 'Registrar';

  @override
  _RegistrarState createState() => _RegistrarState();
}

class _RegistrarState extends State<Registrar> {
  final _globalKey = GlobalKey<FormState>();
  var _formValues = {};

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
                  if (value == null || !_isValidEmail(value))
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
                initialValue: _formValues['password'],
                decoration: InputDecoration(
                    labelText: 'Repita a senha', border: OutlineInputBorder()),
                validator: (value) {
                  if (value == null || !_isValidEmail(value))
                    return 'O email precisa ser válido!';
                  return null;
                },
                onSaved: (value) {
                  _formValues['email'] = value;
                },
              ),
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

  /// Regex simples de validação de email
  bool _isValidEmail(String email) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }

  bool _registrar() {
    return true;
  }
}
