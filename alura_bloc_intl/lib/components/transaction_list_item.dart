import 'package:alura_bloc_intl/models/transaction_model.dart';
import 'package:flutter/material.dart';

class TransactionListItem extends StatelessWidget {
  final Transaction transaction;
  const TransactionListItem(this.transaction, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.monetization_on),
        title: Text(
          transaction.value.toString(),
          style: const TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          transaction.contact.accountNumber.toString(),
          style: const TextStyle(fontSize: 16.0),
        ),
      ),
    );
  }
}
