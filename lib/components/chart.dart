import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// Components
import 'chartBar.dart';

// Models
import '../models/transactions.dart';

class Chart extends StatelessWidget {
  final List<Transactions> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get _groupedTransactions {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );

      String weekDayAbbreviation = DateFormat.E().format(weekDay)[0];

      double totalSum = 0.0;

      for(var i = 0; i < recentTransactions.length; i++) {
        bool isSameDay = recentTransactions[i].date.day == weekDay.day;
        bool isSameMonth = recentTransactions[i].date.month == weekDay.month;
        bool isSameYear = recentTransactions[i].date.year == weekDay.year;

        if(isSameDay && isSameMonth && isSameYear) {
          totalSum += recentTransactions[i].value;
        }
      }

      return { 'day': weekDayAbbreviation, 'value': totalSum };
    });
  }

  double get _weekTotalValue {
    return _groupedTransactions.fold(0.0, (sum, transaction) {
      return sum + transaction['value'];
    });
  }

  @override
  Widget build(BuildContext ctx) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),

      child: Padding(
        padding: EdgeInsets.all(10),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,

          children: recentTransactions.isEmpty ? [] : _groupedTransactions.map((transaction) {
            return Expanded(
              child: ChartBar(
                weekDayLabel: transaction['day'],
                priceValue: transaction['value'],
                percentage: (transaction['value'] as double) / _weekTotalValue,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
