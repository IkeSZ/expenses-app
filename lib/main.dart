import 'package:flutter/material.dart';
import 'dart:math';

// Components
import './components/transactionForm.dart';
import './components/transactionList.dart';
import './components/chart.dart';

// Models
import './models/transactions.dart';

void main() => runApp(ExpensesApp());

class ExpensesApp extends StatelessWidget {
  @override
  Widget build(BuildContext ctx) {
    return MaterialApp(
      home: MyHomePage(),
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        fontFamily: 'Poppins'
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>  {
  final List<Transactions> _transactions = [
    // Transactions(
    //     id: 't0',
    //     title: 'Conta de Luz',
    //     value: 250.20,
    //     date: DateTime.now().subtract(Duration(days: 33)),
    // ),
    // Transactions(
    //     id: 't1',
    //     title: 'Tênis Jordan One Take II',
    //     value: 549.99,
    //     date: DateTime.now().subtract(Duration(days: 3)),
    // ),
  ];

  List<Transactions> get _recentTransaction {
    return _transactions.where((transaction) {
      return transaction.date.isAfter(DateTime.now().subtract(
          Duration(days: 7)
      ));
    }).toList();
  }

  _addNewTransaction(String title, double value) {
    final newTransaction = Transactions(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: DateTime.now()
    );

    setState(() {
      _transactions.add(newTransaction);
    });

    Navigator.of(context).pop();
  }

  _openTransactionFormModal(BuildContext ctx) {
    showModalBottomSheet(context: ctx, builder: (context) {
      return TransactionForm(onSubmit: _addNewTransaction);
    });
  }

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      appBar: AppBar(title: Text('Despesas Pessoais'), actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => _openTransactionFormModal(ctx),
        )
      ],),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,

          children: <Widget>[
            _transactions.isEmpty ? Container() : Chart(_recentTransaction),
            TransactionList(_transactions),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add, color: Colors.white),
        onPressed: () => _openTransactionFormModal(ctx),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
