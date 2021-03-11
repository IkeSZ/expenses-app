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
  final List<Transactions> _transactions = [];
  bool _showChart = false;

  List<Transactions> get _recentTransaction {
    return _transactions.where((transaction) {
      return transaction.date.isAfter(DateTime.now().subtract(
          Duration(days: 7)
      ));
    }).toList();
  }

  _addNewTransaction(String title, double value, DateTime date) {
    final newTransaction = Transactions(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: date
    );

    setState(() {
      _transactions.add(newTransaction);
    });

    Navigator.of(context).pop();
  }

  _removeTransaction(String id) {
    setState(() {
      _transactions.removeWhere((transaction) => transaction.id == id);
    });
  }

  _openTransactionFormModal(BuildContext ctx) {
    showModalBottomSheet(isScrollControlled: true, context: ctx, builder: (context) {
      return TransactionForm(onSubmit: _addNewTransaction);
    });
  }

  @override
  Widget build(BuildContext ctx) {
    bool isLandscape = MediaQuery.of(ctx).orientation == Orientation.landscape;

    final _appBar = AppBar(title: Text('Despesas Pessoais', style: TextStyle(
      fontSize: 20 * MediaQuery.of(ctx).textScaleFactor
    )), actions: <Widget>[
      if (isLandscape)
        IconButton(
          icon: Icon(_showChart ? Icons.list : Icons.pie_chart),
          onPressed: () {
            setState(() {
              _showChart = !_showChart;
            });
          },
        ),
      IconButton(
        icon: Icon(Icons.add),
          onPressed: () => _openTransactionFormModal(ctx),
        ),
      ],
    );

    final _availableHeight = MediaQuery.of(ctx).size.height
        - _appBar.preferredSize.height - MediaQuery.of(ctx).padding.top;

    return Scaffold(
      appBar: _appBar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,

          children: <Widget>[
            if (_showChart || !isLandscape)
            Container(
              height: _availableHeight * (isLandscape ? 0.7 : 0.3),

              child: Chart(_recentTransaction),
            ),

            if(!_showChart || !isLandscape)
            Container(
              height: _availableHeight * 0.70,

              child: TransactionList(_transactions, _removeTransaction),
            ),
          ],
        ),
      ),
    );
  }
}
