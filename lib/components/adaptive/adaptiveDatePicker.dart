import 'dart:io';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AdaptiveDatePicker extends StatelessWidget {
  final DateTime selectedDate;
  final Function(DateTime) onDateChange;

  AdaptiveDatePicker({ this.selectedDate, this.onDateChange });

  _showDatePicker(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if(pickedDate == null) {
        return;
      }

      onDateChange(pickedDate);
    });
  }

  @override
  Widget build(BuildContext ctx) {
    return Platform.isIOS ? Container(
      height: 180,

      child: CupertinoDatePicker(
        mode: CupertinoDatePickerMode.date,
        initialDateTime: DateTime.now(),
        minimumDate: DateTime(2021),
        maximumDate: DateTime.now(),

        onDateTimeChanged: onDateChange,
      ),
    ) : Container(
      height: 70,
      alignment: Alignment.bottomCenter,

      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
                selectedDate == null ? 'Nenhuma data selecionada!!'
                    : 'Data selecionada: ${DateFormat('dd/MM/y').format(selectedDate)}'
            ),
          ),

          FlatButton(
              onPressed: () => _showDatePicker(ctx),
              textColor: Theme.of(ctx).primaryColor,

              child: Text('Selecionar Data', style: TextStyle(
                  fontWeight: FontWeight.w600
              ))),
        ],
      ),
    );
  }
}
