import 'package:alura_bloc_intl/bloc/blocView.dart';
import 'package:alura_bloc_intl/bloc/containers/TransactionForm_container.dart';
import 'package:alura_bloc_intl/bloc/cubits/ContactList_cubit.dart';
import 'package:alura_bloc_intl/components/centeredMessage.dart';
import 'package:alura_bloc_intl/components/contatct_list_item.dart';
import 'package:alura_bloc_intl/components/loading.dart';
import 'package:alura_bloc_intl/models/contact_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:alura_bloc_intl/models/contactListState.dart';
import 'contact_form_page.dart';

class LoadingContactsListSate extends ContactsListState {
  LoadingContactsListSate();
  @override
  Widget build(BuildContext context) {
    return const Loading();
  }
}

class EmptyContactListState extends ContactsListState {
  EmptyContactListState();
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CenteredMessage(
        message: 'Nenhum Contato cadastrado',
        icon: Icons.warning,
      ),
    );
  }
}

class InitContacsListState extends ContactsListState {
  InitContacsListState();
  @override
  Widget build(BuildContext context) {
    return const Loading();
  }
}

class LoadedContactsListSate extends ContactsListState with BlocView {
  final List<Contact> _contacts;
  LoadedContactsListSate(this._contacts);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _contacts.length,
      itemBuilder: (ctx, index) => ContactListItem(
        contact: _contacts[index],
        onTap: () {
          push(
            context,
            TransactionFormContainer(
              contact: _contacts[index],
            ),
          );
        },
      ),
    );
  }
}

class FatalErrorContactsListState extends ContactsListState {
  FatalErrorContactsListState();

  @override
  Widget build(BuildContext context) {
    return const CenteredMessage(message: 'Unkonwn error');
  }
}

class ContactListPage extends StatelessWidget {
  const ContactListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transfer'),
      ),
      body: BlocBuilder<ContactListCubit, ContactsListState>(
        builder: (ctx, state) {
          return state.build(ctx);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ContactFormPage(),
            ),
          );
          context.read<ContactListCubit>().reload();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
