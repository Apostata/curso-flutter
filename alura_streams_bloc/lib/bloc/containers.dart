import 'package:alura_streams_bloc/models/contact_model.dart';
import 'package:alura_streams_bloc/models/transactionFormState.dart';
import 'package:alura_streams_bloc/pages/transaction_form_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../pages/contact_list_page.dart';
import '../pages/dashboard_page.dart';
import '../pages/name_page.dart';
import 'cubits.dart';

class DashboardContiner extends StatelessWidget {
  final String initialState;
  const DashboardContiner({
    Key? key,
    required this.initialState,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (contextBloc) => NameCubit(initialState),
      child: DashboardPage(),
    );
  }
}

class NameContainer extends StatelessWidget {
  const NameContainer({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (blocContext) => NameCubit('Rene'),
      child: NamePage(),
    );
  }
}

class ContactListContainer extends StatelessWidget {
  const ContactListContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ContactListCubit>(
      create: (contextBloc) {
        final cubit = ContactListCubit();
        cubit.reload();
        return cubit;
      },
      child: const ContactListPage(),
    );
  }
}

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
