import 'package:flutter/material.dart';

// Components
import './components/transactionUser.dart';

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
  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      appBar: AppBar(title: Text('Despesas Pessoais'), backgroundColor: Colors.deepPurple),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,

        children: <Widget>[
          Container(
            child: Card(
              color: Colors.deepPurple,
              child: Text('Gráfico'),
            ),
          ),

          TransactionUser(),
        ],
      ),
    );
  }
}
