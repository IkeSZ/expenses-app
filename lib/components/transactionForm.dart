import 'package:flutter/material.dart';

class TransactionForm extends StatelessWidget {
  final titleController = TextEditingController();
  final valueController = TextEditingController();

  Widget build(BuildContext ctx) {
    return  Card(
      elevation: 5,

      child: Container(
        padding: const EdgeInsets.all(10),

        child: Column(
          children: [
            TextField(
              controller: titleController,

              decoration: InputDecoration(
                  labelText: 'Título'
              ),
            ),
            TextField(
              controller: valueController,

              decoration: InputDecoration(
                  labelText: 'Valor (R\$)'
              ),
            ),

            Container(
              margin: EdgeInsets.fromLTRB(0, 10, 0, 0),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,

                children: [
                  FlatButton(
                    child: Text('Nova Transação'),

                    color: Colors.deepPurple,
                    textColor: Colors.white,

                    onPressed: () {},
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
