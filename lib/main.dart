import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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

          Column(
            children: _transactions.map((transaction) {
              return Card(
                child: Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      padding: EdgeInsets.all(10),

                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.deepPurple,

                          width: 2,
                        )
                      ),

                      child: Text(
                        'R\$ ${transaction.value.toStringAsFixed(2)}',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.deepPurple)
                      ),
                    ),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        Text(transaction.title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        Text(DateFormat('d MMM y').format(transaction.date), style: TextStyle(color: Colors.grey)),
                      ],
                    )
                  ],
                ),
              );
            }).toList(),
          )
        ],
      ),
    );
  }
}
