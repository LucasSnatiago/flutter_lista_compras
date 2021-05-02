import 'package:flutter/material.dart';
import 'package:flutter_lista_compras/banco_de_dados/banco.dart';
import 'package:flutter_lista_compras/telas/MenuApp.dart';
import 'package:flutter_lista_compras/telas/editarProduto.dart';
import 'package:intl/intl.dart';
import 'package:money2/money2.dart';

class ExibirProduto extends StatefulWidget {
  static const routeName = 'ExibirProduto';

  @override
  _ExibirProdutoState createState() => _ExibirProdutoState();
}

class _ExibirProdutoState extends State<ExibirProduto> {
  Currency brlCurrency = Currency.create('BRL', 2, symbol: 'R\$');

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
                'Preço: ' +
                    Money.fromInt(
                            _parseDoubleToInt(argumentos['preco']), brlCurrency)
                        .toString(),
                style: TextStyle(fontSize: 26),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Descrição do produto: ' + argumentos['descricao'],
                style: TextStyle(fontSize: 26),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Dia do pagamento: ' +
                    DateFormat('dd/MM/yyyy')
                        .format(DateTime.parse(argumentos['dia_pagamento'])),
                style: TextStyle(fontSize: 26),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 360,
              ),
              ElevatedButton(
                  onPressed: () => _marcarComoPago(context, argumentos),
                  child: Text(
                    'Deletar produto',
                    style: TextStyle(fontSize: 26),
                  )),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _editarProduto(argumentos),
        child: Icon(Icons.edit),
      ),
    );
  }

  int _parseDoubleToInt(double preco) {
    return (preco * 100).toInt();
  }

  _marcarComoPago(context, Map<String, dynamic> produto) async {
    await SQLDatabase.delete('conta', produto['id']);
    Navigator.of(context).pop();
  }

  _editarProduto(Map<String, dynamic> produto) {
    Navigator.of(context)
        .pushNamed(EditarProduto.routeName, arguments: produto);
  }
}
