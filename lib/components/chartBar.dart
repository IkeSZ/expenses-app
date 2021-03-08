import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String weekDayLabel;
  final double priceValue;
  final double percentage;

  ChartBar({ this.weekDayLabel, this.priceValue, this.percentage });

  @override
  Widget build(BuildContext ctx) {
    return Column(
      children: <Widget>[
        Container(
          height: 20,

          child: FittedBox(
            child: Text('${priceValue.toStringAsFixed(2)}'),
          ),
        ),

        SizedBox(height: 5),

        Container(
          height: 60,
          width: 10,

          child: Stack(
            alignment: Alignment.bottomCenter,

            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1.0),
                  borderRadius: BorderRadius.circular(5),

                  color: Color.fromRGBO(220, 220, 220, 0.5)
                ),
              ),

              FractionallySizedBox(
                heightFactor: percentage,

                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Theme.of(ctx).primaryColor,
                  ),
                ),
              )
            ],
          ),
        ),

        SizedBox(height: 5),
        Text(weekDayLabel),
      ],
    );
  }
}
