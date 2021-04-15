import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double) _addTransaction;

  TransactionForm(this._addTransaction);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleControler = TextEditingController();
  final _valueControler = TextEditingController();
  DateTime _datePickerControler;

  _onSubmit() {
    final String title = _titleControler.text;
    final double value = double.tryParse(_valueControler.text) ?? 0.0;

    if (title.isEmpty || value <= 0) return;
    widget._addTransaction(title, value);
  }

  _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day - 7,
      ),
      firstDate: DateTime.now().subtract(Duration(days: 365)),
      lastDate: DateTime.now(),
      locale: Locale('pt', 'BR'),
    ).then((dateSelected) {
      if (dateSelected == null) {
        return;
      }
      setState(() {
        _datePickerControler = dateSelected;
      });
    });
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
              controller: _titleControler,
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
              controller: _valueControler,
            ),
            Container(
              height: 70,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      _datePickerControler != null
                          ? 'Data Selecionada: ${DateFormat('dd/MM/yyyy').format(_datePickerControler)}'
                          : 'Nenhuma data selecionada!',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  TextButton(
                    child: Text(
                      'Selecionar Data',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: _showDatePicker,
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: _onSubmit,
                  child: Text(
                    'Nova transação',
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
