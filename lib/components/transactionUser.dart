import 'package:flutter/material.dart';

// Models
import '../models/transactions.dart';

// Components
import 'package:expenses_app/components/transactionList.dart';
import 'package:expenses_app/components/transactionForm.dart';

class _TransactionUserState extends State<TransactionUser> {
  final _transactions = [
    Transactions(id: 't1', title: 'Conta de Luz', value: 250.20, date: DateTime.now()),
    Transactions(id: 't2', title: 'Tênis Jordan One Take II', value: 549.99, date: DateTime.now()),
  ];

  @override
  Widget build(BuildContext ctx) {
    return Column(
      children: [
        TransactionList(_transactions),
        TransactionForm(),
      ],
    );
  }
}

class TransactionUser extends StatefulWidget {
  @override
  _TransactionUserState createState() => _TransactionUserState();
}
