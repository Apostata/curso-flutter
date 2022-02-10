import 'dart:async';

import 'package:alura_bloc_intl/errors/httpException.dart';
import 'package:alura_bloc_intl/helpers/showDialogs.dart';
import 'package:alura_bloc_intl/models/transactionFormState.dart';
import 'package:alura_bloc_intl/models/transaction_model.dart';
import 'package:alura_bloc_intl/pages/transaction_form_page.dart';
import 'package:alura_bloc_intl/services/transaction_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
