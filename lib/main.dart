import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:math';
import 'dart:io';

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

  Widget _getIconButton({ IconData icon, Function fn }) {
    return Platform.isIOS ? GestureDetector(
      onTap: fn,
      child: Icon(icon),
    ) : IconButton(
      icon: Icon(icon),
      onPressed: fn,
    );
  }

  @override
  Widget build(BuildContext ctx) {
    final mediaQuery = MediaQuery.of(ctx);

    bool isLandscape = mediaQuery.orientation == Orientation.landscape;

    final actions = <Widget>[
      if (isLandscape)
        _getIconButton(
          icon: _showChart ? (
              Platform.isIOS ? CupertinoIcons.list_bullet : Icons.list
          ) : (
              Platform.isIOS ? CupertinoIcons.chart_bar_square : Icons.pie_chart
          ),
          fn: () {
            setState(() {
              _showChart = !_showChart;
            });
          }
        ),
      _getIconButton(
        icon: Platform.isIOS ? CupertinoIcons.add : Icons.add,
        fn: () => _openTransactionFormModal(ctx),
      ),
    ];

    final PreferredSizeWidget _appBar = Platform.isIOS ? CupertinoNavigationBar(
      middle: Text('Despesas Pessoais'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: actions,
      ),
    ) : AppBar(title: Text('Despesas Pessoais', style: TextStyle(
      fontSize: 20 * mediaQuery.textScaleFactor
    )), actions: actions
    );

    final _availableHeight = mediaQuery.size.height
        - _appBar.preferredSize.height - mediaQuery.padding.top;

    final bodyPage = SafeArea(
      child: SingleChildScrollView(
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
                height: _availableHeight * (isLandscape ? 1 : 0.7),

                child: TransactionList(_transactions, _removeTransaction),
              ),
          ],
        ),
      ),
    );

    return Platform.isIOS ? CupertinoPageScaffold(
      navigationBar: _appBar,
      child: bodyPage,
    ) : Scaffold(
      appBar: _appBar,
      body: bodyPage,
    );
  }
}
