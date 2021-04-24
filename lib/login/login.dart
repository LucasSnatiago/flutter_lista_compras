import 'package:flutter/material.dart';

class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  final _formKey = GlobalKey<FormState>();

  var _formValues = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Entre na sua conta'),
      ),
      body: SingleChildScrollView(
        key: _formKey,
        child: Form(
            child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Entre com sua conta: '),
              Text(''),
              TextFormField(
                key: ValueKey('email'),
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
                  onPressed: () => Navigator.of(context).pushNamed('Registrar'),
                  child: Text('Registrar-se'))
            ],
          ),
        )),
      ),
    );
  }

  _login() {}
}
