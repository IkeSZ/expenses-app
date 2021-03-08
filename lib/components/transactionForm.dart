import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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

  Widget build(BuildContext ctx) {
    return  Card(
      elevation: 5,

      child: Container(
        padding: const EdgeInsets.all(10),

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
                  RaisedButton(
                    child: Text('Nova Transação'),

                    color: Colors.deepPurple,
                    textColor: Colors.white,

                    onPressed: _submitForm
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
