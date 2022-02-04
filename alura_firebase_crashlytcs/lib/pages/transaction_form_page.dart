import 'dart:async';

import 'package:alura_firebase_crashlytcs/components/loadingButton.dart';
import 'package:alura_firebase_crashlytcs/components/transaction_auth_dialog.dart';
import 'package:alura_firebase_crashlytcs/errors/httpException.dart';
import 'package:alura_firebase_crashlytcs/helpers/ErrorsCrashalytics.dart';
import 'package:alura_firebase_crashlytcs/helpers/showDialogs.dart';
import 'package:alura_firebase_crashlytcs/helpers/showSnackBar.dart';
import 'package:alura_firebase_crashlytcs/services/transaction_service.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

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
  final String transactionId = const Uuid().v4();
  bool _loading = false;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  void _save(
    Transaction transactionCreated,
    String? password,
    BuildContext context,
  ) async {
    setState(() {
      _loading = true;
    });
    try {
      await widget.transactionService.save(
        transactionCreated,
        password,
      );
      // await showSuccessDialog(context, message: 'Success Transaction');
      await showSnackbar(
        context: context,
        message: 'Success Transaction',
        icon: Icons.check,
        iconColor: Colors.green,
        onClose: () {
          Navigator.pop(context);
        },
      );
    } on TimeoutException catch (e) {
      sendCrashalytics(e, transactionCreated.toString());
      // showErrorDialog(context, message: 'Timeout submitting transaction');
      showSnackbar(
        context: context,
        message: 'Timeout error',
        icon: Icons.warning,
        iconColor: Colors.red,
      );
    } on HttpException catch (e) {
      sendCrashalytics(e, transactionCreated.toString());
      // showErrorDialog(context, message: e.message);
      showSnackbar(
        context: context,
        message: e.message,
        icon: Icons.warning,
        iconColor: Colors.red,
      );
    } catch (e) {
      sendCrashalytics(e, transactionCreated.toString());
      // showErrorDialog(context);
      showSnackbar(
        context: context,
        message: 'Unknow Error!',
        icon: Icons.warning,
        iconColor: Colors.red,
      );
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
                  child: LoadingButton(
                    loading: _loading,
                    text: _loading ? 'Sending' : 'Transfer',
                    onPress: _loading
                        ? null
                        : () {
                            final double? value =
                                double.tryParse(_valueController.text);
                            final transactionCreated = Transaction(
                                transactionId, value, widget.contact);
                            showDialog(
                              context: context,
                              builder: (dialogCtx) => TransactionAuthDialog(
                                onConfirm: (String? password) {
                                  _save(transactionCreated, password, context);
                                  // print(transactionId);
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
