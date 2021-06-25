import 'package:expenses/components/adaptative_datePicker.dart';
import 'package:flutter/material.dart';
import 'adaptative_button.dart';
import 'adaptative_textField.dart';
import 'adaptative_datePicker.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double, DateTime) _addTransaction;

  TransactionForm(this._addTransaction) {
    print('transaction form: constructor');
  }

  @override
  _TransactionFormState createState() {
    print('transaction form: create state');
    return _TransactionFormState();
  }
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleControler = TextEditingController();
  final _valueControler = TextEditingController();
  DateTime _datePickerControler = DateTime.now();

  _TransactionFormState() {
    print('transaction form state: constructor');
  }

  @override
  void initState() {
    super.initState();
    print('transaction form state: initState()');
  }

  @override
  void didUpdateWidget(Widget oldWidget) {
    super.didUpdateWidget(oldWidget);
    // final bool isEqual = widget != oldWidget;
    // print(isEqual);
    print('transaction form state: didUpdateWidget()');
  }

  @override
  void dispose() {
    super.dispose();
    print('transaction form state: dispose()');
  }

  _onSubmit() {
    final String title = _titleControler.text;
    final double value = double.tryParse(_valueControler.text) ?? 0.0;
    if (title.isEmpty || value <= 0 || _datePickerControler == null) return;
    widget._addTransaction(title, value, _datePickerControler);
  }

  @override
  Widget build(BuildContext context) {
    print('transaction form state: build()');
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Padding(
          padding: EdgeInsets.only(
            top: 10,
            right: 10,
            left: 10,
            bottom: 10 + MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            children: <Widget>[
              AdaptativeTextField(
                label: 'Título',
                controller: _titleControler,
                onSubmitted: (_) => _onSubmit(),
              ),
              AdaptativeTextField(
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ), // para mostrar teclado copleto numerico no IOS
                onSubmitted: (_) => _onSubmit(),
                label: 'valor (R\$)',
                controller: _valueControler,
              ),
              AdaptativeDatePicker(
                onDateChange: (newDate) {
                  setState(() {
                    _datePickerControler = newDate;
                  });
                },
                selectedDate: _datePickerControler,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AdaptiveButton(
                    onPressed: _onSubmit,
                    label: 'Nova transação',
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
