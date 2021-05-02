import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExibirProduto extends StatefulWidget {
  static const routeName = 'ExibirProduto';

  @override
  _ExibirProdutoState createState() => _ExibirProdutoState();
}

class _ExibirProdutoState extends State<ExibirProduto> {
  @override
  Widget build(BuildContext context) {
    final argumentos =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return Scaffold(
      appBar: AppBar(
        title: Text(argumentos['titulo']),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              Text(
                'Preço: ' + argumentos['preco'],
                style: TextStyle(fontSize: 26),
                textAlign: TextAlign.start,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Descrição do produto: ' + argumentos['descricao'],
                style: TextStyle(fontSize: 26),
                textAlign: TextAlign.start,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Dia do pagamento: ' +
                    DateFormat('dd/MM/yyyy')
                        .format(DateTime.parse(argumentos['dia_pagamento'])),
                style: TextStyle(fontSize: 26),
                textAlign: TextAlign.start,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
