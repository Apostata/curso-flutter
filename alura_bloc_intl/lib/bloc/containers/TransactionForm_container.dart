import 'package:alura_bloc_intl/bloc/cubits/TransactionForm_cubit.dart';
import 'package:alura_bloc_intl/models/contact_model.dart';
import 'package:alura_bloc_intl/models/transactionFormState.dart';
import 'package:alura_bloc_intl/pages/transaction_form_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionFormContainer extends StatelessWidget {
  final Contact contact;
  const TransactionFormContainer({
    Key? key,
    required this.contact,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TransactionFormCubit>(
      create: (context) {
        final cubit = TransactionFormCubit();
        return cubit;
      },
      child: BlocListener<TransactionFormCubit, TransactionFormState>(
        listener: (context, state) {
          if (state is InitTransactionFormState) {
            print('enviou!');
          }
        },
        child: TransactionFormPage(
          contact: contact,
        ),
      ),
    );
  }
}
