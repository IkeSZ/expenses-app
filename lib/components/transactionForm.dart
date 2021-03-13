import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// Components
import './adaptive/adaptiveButton.dart';
import './adaptive/adaptiveTextField.dart';
import './adaptive/adaptiveDatePicker.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double, DateTime) onSubmit;

  TransactionForm({ this.onSubmit });

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleController = TextEditingController();
  final _valueController = TextEditingController();

  DateTime _selectedDate = DateTime.now();

  _submitForm() {
    final title = _titleController.text;
    final value = double.tryParse(_valueController.text) ?? 0.0;

    if(title.isEmpty || value <= 0 || _selectedDate == null) {
      return;
    }

    return widget.onSubmit(title, value, _selectedDate);
  }

  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,

        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            right: 10,
            left: 10,
            bottom: 10 +  MediaQuery.of(context).viewInsets.bottom,
          ),

          child: Column(
            children: [
              AdaptiveTextField(
                controller: _titleController,

                onSubmitted: (_) => _submitForm(),

                label: 'Título',
              ),
              AdaptiveTextField(
                controller: _valueController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),

                onSubmitted: (_) => _submitForm(),

                label: 'Valor (R\$)',
              ),

              AdaptiveDatePicker(
                selectedDate: _selectedDate,
                onDateChange: (newDate) {
                  setState(() {
                    _selectedDate = newDate;
                  });
                },
              ),

              Container(
                margin: EdgeInsets.fromLTRB(0, 10, 0, 0),

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,

                  children: <Widget>[
                    AdaptiveButton(
                      label: 'Nova Transação',
                      onPressed: _submitForm,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
