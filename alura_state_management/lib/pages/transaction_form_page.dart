import 'dart:async';

import 'package:alura_state_management/components/loadingButton.dart';
import 'package:alura_state_management/components/transaction_auth_dialog.dart';
import 'package:alura_state_management/errors/httpException.dart';
import 'package:alura_state_management/helpers/ErrorsCrashalytics.dart';
import 'package:alura_state_management/helpers/showDialogs.dart';
import 'package:alura_state_management/helpers/showSnackBar.dart';
import 'package:alura_state_management/helpers/showToast.dart';
import 'package:alura_state_management/services/transaction_service.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../helpers/currency.dart';
import '../models/contact_model.dart';
import '../models/transaction_model.dart';
import 'package:provider/provider.dart';
import '../Providers/Saldo_provider.dart';

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
      await showSuccessSnackbar(
          context: context, message: 'Success Transaction');
      // await showSuccessToast(message: 'Success Transaction');
    } on TimeoutException catch (e) {
      //sendCrashalytics(e, transactionCreated.toString());
      // showErrorDialog(context, message: 'Timeout submitting transaction');
      showErrorSnackbar(context: context, message: 'Timeout error');
      // showErrorToast(message: 'Timeout error');
    } on HttpException catch (e) {
      //sendCrashalytics(e, transactionCreated.toString());
      // showErrorDialog(context, message: e.message);
      showErrorSnackbar(context: context, message: e.message);
      // showErrorToast(message: e.message);
    } catch (e) {
      //sendCrashalytics(e, transactionCreated.toString());
      // showErrorDialog(context);
      showErrorSnackbar(context: context);
      // showErrorToast();
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final saldoProvider = Provider.of<Saldo>(context, listen: false);

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
                            final double value =
                                double.tryParse(_valueController.text) ?? 0;
                            if (value > 0) {
                              final transactionCreated = Transaction(
                                  transactionId, value, widget.contact);
                              showDialog(
                                context: context,
                                builder: (dialogCtx) => TransactionAuthDialog(
                                  onConfirm: (String? password) {
                                    if (saldoProvider.value >= value) {
                                      saldoProvider.removeValue(value);
                                      _save(transactionCreated, password,
                                          context);
                                    } else {
                                      showErrorSnackbar(
                                          context: context,
                                          message:
                                              'Insuficient sald! Available: ${toCurrency(saldoProvider.value)}');
                                    }
                                    // print(transactionId);
                                  },
                                  onCancel: () {},
                                ),
                              );
                            }
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
