import 'package:flutter/material.dart';

class TransactionForm extends StatelessWidget {
  final titleControler = TextEditingController();
  final valueControler = TextEditingController();
  final void Function(String, double) _addTransaction;

  TransactionForm(this._addTransaction);

  _onSubmit() {
    final String title = titleControler.text;
    final double value = double.tryParse(valueControler.text) ?? 0.0;

    if (title.isEmpty || value <= 0) return;
    _addTransaction(title, value);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Título'),
              controller: titleControler,
              onSubmitted: (_) => _onSubmit(),
            ),
            TextField(
              keyboardType: TextInputType.numberWithOptions(
                decimal: true,
              ), // para mostrar teclado copleto numerico no IOS
              onSubmitted: (_) => _onSubmit(),
              decoration: InputDecoration(
                labelText: 'valor (R\$)',
              ),
              controller: valueControler,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: _onSubmit,
                  child: Text(
                    'Nova transação',
                    style: TextStyle(
                      color: Colors.purple,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
