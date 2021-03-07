import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// Models
import '../models/transactions.dart';

class TransactionList extends StatelessWidget {
  final List<Transactions> transactions;

  TransactionList(this.transactions);

  @override
  Widget build(BuildContext ctx) {
    return Container(
      height: 600,

      child: transactions.isEmpty ? Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(0, 20, 0, 20),

            child: Text('Nenhuma Transação Cadastrada!', style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600
            )),
          ),

          Container(
            height: 200,
            child: Image.asset('assets/images/waiting.png', fit: BoxFit.cover),
          )
        ],
      ) : ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (_, index) {
          final transaction = transactions[index];

          return Card(
            child: Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  padding: EdgeInsets.all(10),

                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Theme.of(ctx).primaryColor,

                        width: 2,
                      )
                  ),

                  child: Text(
                      'R\$ ${transaction.value.toStringAsFixed(2)}',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Theme.of(ctx).primaryColor)
                  ),
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Text(transaction.title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    Text(DateFormat('d MMM y').format(transaction.date), style: TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.w300
                    )),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
