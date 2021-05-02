import 'package:flutter/material.dart';
import 'package:flutter_lista_compras/banco_de_dados/banco.dart';
import 'package:flutter_lista_compras/telas/MenuApp.dart';
import 'package:intl/intl.dart';

class EditarProduto extends StatefulWidget {
  static const routeName = 'EditarProduto';

  @override
  _EditarProdutoState createState() => _EditarProdutoState();
}

class _EditarProdutoState extends State<EditarProduto> {
  final _globalKey = GlobalKey<FormState>();
  Map<String, dynamic> _formValues = {};
  late DateTime selectedDate;

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    _formValues = Map.of(args);
    selectedDate = DateTime.parse(args['dia_pagamento']);

    return Scaffold(
      appBar: AppBar(
        title: Text('Editar produto'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Form(
              key: _globalKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Edite seu produto',
                    style: TextStyle(fontSize: 26),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    key: ValueKey('titulo'),
                    initialValue: _formValues['titulo'],
                    validator: (value) => value!.trim().isEmpty
                        ? 'O produto precisa possuir um nome'
                        : null,
                    autocorrect: true,
                    onSaved: (newValue) => _formValues['titulo'] = newValue,
                    decoration: InputDecoration(
                      labelText: 'Nome do produto',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    key: ValueKey('preco'),
                    initialValue: _formValues['preco'].toString(),
                    onSaved: (newPrice) => _formValues['preco'] = newPrice,
                    keyboardType: TextInputType.number,
                    validator: (value) =>
                        (value!.trim().isEmpty && (double.parse(value) >= 0.0))
                            ? 'O valor não pode ser negativo'
                            : null,
                    decoration: InputDecoration(
                      labelText: 'Valor do produto',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    key: ValueKey('descricao'),
                    initialValue: _formValues['descricao'],
                    autocorrect: true,
                    validator: (value) => (value == null || value.isEmpty)
                        ? 'O produto precisa possuir uma descrição'
                        : null,
                    onSaved: (newValue) => _formValues['descricao'] = newValue,
                    decoration: InputDecoration(
                      alignLabelWithHint: true,
                      labelText: 'Descrição do produto',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 8,
                  ),
                  SizedBox(
                    height: 25,
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
                    height: 30,
                  ),
                  ElevatedButton.icon(
                    onPressed: () => _salvarProdutoEditado(context),
                    icon: Icon(Icons.save),
                    label: Text('Salvar edição do produto'),
                  ),
                ],
              )),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final now = DateTime.now();

    final DateTime? picked = await showDatePicker(
        locale: const Locale('pt', 'BR'),
        context: context,
        firstDate: now,
        lastDate: DateTime(now.year + 100),
        initialDate: now);
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  _salvarProdutoEditado(BuildContext context) async {
    _globalKey.currentState!.save();

    if (!(_globalKey.currentState?.validate() ?? true)) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Há erro em algum dos campos!')));

      return;
    }

    var atualizarDB = {
      'titulo': _formValues['titulo'],
      'preco': _formValues['preco'],
      'descricao': _formValues['descricao'],
      'dia_pagamento': selectedDate.toIso8601String(),
    };

    await SQLDatabase.updateByID('conta', _formValues['user_id'], atualizarDB);
    Navigator.of(context).pop();
    Navigator.of(context).pushReplacementNamed(MenuApp.routeName,
        arguments: _formValues['user_id']);
  }
}
