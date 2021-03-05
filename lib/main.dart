import 'package:flutter/material.dart';

// Models
import './models/transactions.dart';

void main() => runApp(ExpensesApp());

class ExpensesApp extends StatelessWidget {
  @override
  Widget build(BuildContext ctx) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final _transactions = [
    Transactions(id: 't1', title: 'Conta de Luz', value: 250.20, date: DateTime.now()),
    Transactions(id: 't2', title: 'Tênis Jordan One Take II', value: 549.99, date: DateTime.now()),
  ];

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      appBar: AppBar(title: Text('Despesas Pessoais'), backgroundColor: Colors.deepPurple),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.stretch,

        children: <Widget>[
          Container(
            child: Card(
              color: Colors.deepPurple,
              child: Text('Gráfico'),
            ),
          ),
          Card(child: Text('Lista de Transações')),
        ],
      ),
    );
  }
}
