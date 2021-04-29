import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NovoProduto extends StatefulWidget {
  static const routeName = 'NovoProduto';

  @override
  _NovoProdutoState createState() => _NovoProdutoState();
}

class _NovoProdutoState extends State<NovoProduto> {
  final _globalKey = GlobalKey<FormState>();
  var _formValues;
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
                    autovalidateMode: AutovalidateMode.onUserInteraction,
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
                    key: ValueKey('descricao'),
                    autocorrect: true,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
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
                ],
              )),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addProdutos(),
        child: Icon(Icons.shopping_cart),
      ),
    );
  }

  _addProdutos() {}

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
}
