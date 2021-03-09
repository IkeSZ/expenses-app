import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// Models
import '../models/transactions.dart';

class TransactionList extends StatelessWidget {
  final List<Transactions> transactions;
  final void Function(String id) removeTransactionFc;

  TransactionList(this.transactions, this.removeTransactionFc);
  
  _fixHighValue(double value) {
    if (value >= 100000) {
      String stringValue = value.toString();
      stringValue = stringValue.substring(0, 3);

      if (value >= 1000000) {
        String stringValue = value.toString();

        final firstValueNumber = stringValue.substring(0, 1);
        final decimalValueNumber = stringValue.substring(2, 4);

        if (value >= 10000000) {
          String stringValue = value.toString();

          final firstValueNumber = stringValue.substring(0, 2);
          final decimalValueNumber = stringValue.substring(4, 6);

          if (value >= 100000000) {
            String stringValue = value.toString();

            return '${stringValue.substring(0, 3)}M';
          }

          return '$firstValueNumber.${decimalValueNumber}M';
        }

        return '$firstValueNumber.${decimalValueNumber}M';
      }

      return '${stringValue}K';
    }

    return value;
  }

  @override
  Widget build(BuildContext ctx) {
    return transactions.isEmpty ? Column(
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
            elevation: 6,
            margin: EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 7,
            ),

            child: ListTile(
              leading: CircleAvatar(
                radius: 30,
                backgroundColor: Colors.deepPurple[600],

                child: Padding(
                  padding: EdgeInsets.all(6),

                  child: FittedBox(
                    child: Text('R\$ ${_fixHighValue(transaction.value)}'),
                  ),
                ),
              ),

              title: Text(transaction.title, style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18,
              )),

              subtitle: Text(
                DateFormat('d MMM y').format(transaction.date),
              ),

              trailing: IconButton(
                icon: Icon(Icons.delete),

                onPressed: () => removeTransactionFc(transaction.id),
              ),
            ),
          );
        },
    );
  }
}
