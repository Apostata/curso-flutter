import 'dart:async';

import 'package:alura_streams_bloc/errors/httpException.dart';
import 'package:alura_streams_bloc/helpers/showDialogs.dart';
import 'package:alura_streams_bloc/models/transactionFormState.dart';
import 'package:alura_streams_bloc/models/transaction_model.dart';
import 'package:alura_streams_bloc/pages/contact_list_page.dart';
import 'package:alura_streams_bloc/pages/transaction_form_page.dart';
import 'package:alura_streams_bloc/services/transaction_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:alura_streams_bloc/models/contactListState.dart';
import 'package:alura_streams_bloc/models/contact_model.dart';
import 'package:alura_streams_bloc/services/contact_service.dart';

class NameCubit extends Cubit<String> {
  NameCubit(String initialName) : super(initialName);
  void change(String name) => emit(name);
}

class ContactListCubit extends Cubit<ContactsListState> {
  final contactService = ContactService();
  ContactListCubit() : super(InitContacsListState());

  void reload() async {
    emit(LoadingContactsListSate());
    List<Contact> contacts = await contactService.readContacts();
    if (contacts.isEmpty) {
      emit(EmptyContactListState());
    } else {
      emit(LoadedContactsListSate(contacts));
    }
  }
}

class TransactionFormCubit extends Cubit<TransactionFormState> {
  final transactionService = TransactionService();
  TransactionFormCubit() : super(InitTransactionFormState());

  void save(
    Transaction transactionCreated,
    String? password,
    BuildContext context,
  ) async {
    emit(SendingTransactionFormSate());
    try {
      await transactionService.save(
        transactionCreated,
        password,
      );
      await showSuccessDialog(context, message: 'Success Transaction');
      Navigator.pop(context);
    } on TimeoutException catch (_) {
      showErrorDialog(context, message: 'Timeout submitting transaction');
    } on HttpException catch (error) {
      showErrorDialog(context, message: error.message);
    } catch (e) {
      showErrorDialog(context);
    } finally {
      emit(InitTransactionFormState());
    }
  }
}
