import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// Components
import './adaptive/adaptiveButton.dart';

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

  _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if(pickedDate == null) {
        return;
      }

      setState(() {
        _selectedDate = pickedDate;
      });
    });
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
              TextField(
                controller: _titleController,

                onSubmitted: (_) => _submitForm(),

                decoration: InputDecoration(
                    labelText: 'Título'
                ),
              ),
              TextField(
                controller: _valueController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),

                onSubmitted: (_) => _submitForm(),

                decoration: InputDecoration(
                    labelText: 'Valor (R\$)'
                ),
              ),

              Container(
                height: 70,
                alignment: Alignment.bottomCenter,

                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                          _selectedDate == null ? 'Nenhuma data selecionada!!'
                              : 'Data selecionada: ${DateFormat('dd/MM/y').format(_selectedDate)}'
                      ),
                    ),

                    FlatButton(
                        onPressed: _showDatePicker,
                        textColor: Theme.of(context).primaryColor,

                        child: Text('Selecionar Data', style: TextStyle(
                            fontWeight: FontWeight.w600
                        ))),
                  ],
                ),
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
