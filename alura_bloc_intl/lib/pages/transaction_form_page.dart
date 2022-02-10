import 'package:alura_bloc_intl/bloc/blocView.dart';
import 'package:alura_bloc_intl/bloc/cubits/TransactionForm_cubit.dart';
import 'package:alura_bloc_intl/components/loadingButton.dart';
import 'package:alura_bloc_intl/components/transaction_auth_dialog.dart';
import 'package:alura_bloc_intl/models/transactionFormState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import '../models/contact_model.dart';
import '../models/transaction_model.dart';

class SendingTransactionFormSate extends TransactionFormState {
  SendingTransactionFormSate();
}

class InitTransactionFormState extends TransactionFormState {
  InitTransactionFormState();
}

class TransactionFormPage extends StatelessWidget with BlocView {
  final Contact contact;
  final TextEditingController _valueController = TextEditingController();
  final String transactionId = const Uuid().v4();

  TransactionFormPage({
    Key? key,
    required this.contact,
  }) : super(key: key);

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
                contact.name,
                style: const TextStyle(
                  fontSize: 24.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  contact.accountNumber.toString(),
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
                    child:
                        BlocBuilder<TransactionFormCubit, TransactionFormState>(
                            builder: (context, state) {
                      bool loading = state is SendingTransactionFormSate;
                      return LoadingButton(
                        loading: loading,
                        text: loading ? 'Sending' : 'Transfer',
                        onPress: loading
                            ? null
                            : () {
                                final double? value =
                                    double.tryParse(_valueController.text);
                                final transactionCreated =
                                    Transaction(transactionId, value, contact);
                                showDialog(
                                  context: context,
                                  builder: (dialogCtx) => TransactionAuthDialog(
                                    onConfirm: (String? password) {
                                      BlocProvider.of<TransactionFormCubit>(
                                              context)
                                          .save(
                                        transactionCreated,
                                        password,
                                        context,
                                      );
                                    },
                                    onCancel: () {},
                                  ),
                                );
                              },
                      );
                    })),
              )
            ],
          ),
        ),
      ),
    );
  }
}
