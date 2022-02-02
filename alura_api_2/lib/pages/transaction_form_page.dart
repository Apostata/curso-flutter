import 'dart:async';

import 'package:alura_api_2/components/response_dialog.dart';
import 'package:alura_api_2/components/transaction_auth_dialog.dart';
import 'package:alura_api_2/errors/httpException.dart';
// import 'package:alura_api_2/errors/httpException.dart';
import 'package:alura_api_2/services/transaction_service.dart';
import 'package:flutter/material.dart';

import '../models/contact_model.dart';
import '../models/transaction_model.dart';

class TransactionFormPage extends StatefulWidget {
  final Contact contact;
  final transactionService = TransactionService();

  TransactionFormPage({Key? key, required this.contact}) : super(key: key);

  @override
  _TransactionFormPageState createState() => _TransactionFormPageState();
}

class _TransactionFormPageState extends State<TransactionFormPage> {
  final TextEditingController _valueController = TextEditingController();

  void _save(
    Transaction transactionCreated,
    String? password,
    BuildContext context,
  ) async {
    try {
      await widget.transactionService.save(
        transactionCreated,
        password,
      );
      Navigator.pop(context);
    } on TimeoutException catch (_) {
      showDialog(
          context: context,
          builder: (ctxDialog) {
            return ResponseDialog(
              title: 'Failure',
              message: 'Timeout submitting transaction',
              icon: Icons.warning,
              // buttonText: 'OK',
              colorIcon: Colors.red,
            );
          });
    } on HttpException catch (error) {
      showDialog(
          context: context,
          builder: (ctxDialog) {
            return ResponseDialog(
              title: 'Failure',
              message: error.message,
              icon: Icons.warning,
              // buttonText: 'OK',
              colorIcon: Colors.red,
            );
          });
    } finally {
      // alguma coisa
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New transaction'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                widget.contact.name,
                style: const TextStyle(
                  fontSize: 24.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  widget.contact.accountNumber.toString(),
                  style: const TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: TextField(
                  controller: _valueController,
                  style: const TextStyle(fontSize: 24.0),
                  decoration: const InputDecoration(labelText: 'Value'),
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: SizedBox(
                  width: double.maxFinite,
                  child: ElevatedButton(
                    child: const Text('Transfer'),
                    onPressed: () {
                      final double? value =
                          double.tryParse(_valueController.text);
                      final transactionCreated =
                          Transaction(value, widget.contact);
                      showDialog(
                        context: context,
                        builder: (dialogCtx) => TransactionAuthDialog(
                          onConfirm: (String? password) {
                            _save(transactionCreated, password, context);
                          },
                          onCancel: () {},
                        ),
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
