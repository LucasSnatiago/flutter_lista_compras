import 'package:flutter/material.dart';
import 'package:flutter_lista_compras/banco_de_dados/banco.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NovoProduto extends StatefulWidget {
  static const routeName = 'NovoProduto';

  @override
  _NovoProdutoState createState() => _NovoProdutoState();
}

class _NovoProdutoState extends State<NovoProduto> {
  final _globalKey = GlobalKey<FormState>();
  var _formValues = {};
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adicione um novo produto'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Form(
            key: _globalKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Defina seu produto',
                  style: TextStyle(fontSize: 26),
                ),
                SizedBox(
                  height: 30,
                ),
                TextFormField(
                  key: ValueKey('titulo'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'O produto precisa possuir um nome';
                    }
                    return null;
                  },
                  autocorrect: true,
                  onSaved: (newValue) => _formValues['titulo'] = newValue,
                  decoration: InputDecoration(
                      labelText: 'Nome do produto',
                      border: OutlineInputBorder()),
                ),
                SizedBox(
                  height: 2,
                ),
                TextFormField(
                  key: ValueKey('preco'),
                  initialValue: _formValues['preco'],
                  onSaved: (newPrice) => _formValues['preco'] = newPrice,
                  keyboardType: TextInputType.number,
                  validator: (value) =>
                      (value == null || (double.parse(value) < 0.0))
                          ? 'O valor não pode ser negativo'
                          : null,
                  decoration: InputDecoration(
                      labelText: 'Valor do produto',
                      border: OutlineInputBorder()),
                ),
                SizedBox(
                  height: 2,
                ),
                TextFormField(
                  key: ValueKey('descricao'),
                  autocorrect: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'O produto precisa possuir uma descrição';
                    }
                    return null;
                  },
                  onSaved: (newValue) => _formValues['descricao'] = newValue,
                  decoration: InputDecoration(
                      alignLabelWithHint: true,
                      labelText: 'Descrição do produto',
                      border: OutlineInputBorder()),
                  maxLines: 8,
                ),
                SizedBox(
                  height: 4,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                        onPressed: () => _selectDate(context),
                        child: Text('Selecione o dia de pagamento')),
                    Text(DateFormat('dd/MM/yyyy').format(selectedDate)),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton.icon(
                    onPressed: _addProdutos(context),
                    icon: Icon(Icons.add_shopping_cart),
                    label: Text('Adicionar produto'))
              ],
            ),
          ),
        ),
      ),
    );
  }

  _addProdutos(context) {
    if (_globalKey.currentState?.validate() ?? false) {
      _globalKey.currentState?.save();
      print('Valores da compra $_formValues');

      loadUserID().then((userId) {
        var produto = {
          'user_id': userId,
          'titulo': _formValues['titulo'],
          'descricao': _formValues['descricao'],
          'dia_pagamento': selectedDate.toIso8601String(),
          'pago': 'false',
        };

        SQLDatabase.insert('conta', produto);

        Navigator.of(context).pop();
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final now = DateTime.now();

    final DateTime? picked = await showDatePicker(
        locale: const Locale('pt', 'PT'),
        context: context,
        firstDate: now,
        lastDate: DateTime(now.year + 100),
        initialDate: now);
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  Future<int> loadUserID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return (prefs.getInt('user_id'))!;
  }
}
