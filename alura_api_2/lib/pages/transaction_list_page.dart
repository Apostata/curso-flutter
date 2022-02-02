import 'package:alura_api_2/components/centeredMessage.dart';
import 'package:alura_api_2/components/loading.dart';
import 'package:alura_api_2/components/transaction_list_item.dart';
import 'package:alura_api_2/models/transaction_model.dart';
import 'package:alura_api_2/services/transaction_service.dart';
import 'package:flutter/material.dart';

class TransactionListPage extends StatelessWidget {
  const TransactionListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final transactionService = TransactionService();

    return Scaffold(
        appBar: AppBar(
          title: const Text('Transaction'),
        ),
        body: FutureBuilder<List<Transaction>>(
          future: transactionService.findAll(),
          initialData: const <Transaction>[],
          builder: (ctx, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                break;
              case ConnectionState.waiting:
                return const Loading();
              case ConnectionState.active:
                break;
              case ConnectionState.done:
                final transactions = snapshot.data;
                if (transactions == null || transactions.isEmpty) {
                  return const CenteredMessage(
                    message: 'No transactions found!',
                    icon: Icons.warning,
                  );
                } else {
                  return ListView.builder(
                    itemCount: transactions.length,
                    itemBuilder: ((ctx, idx) =>
                        TransactionListItem(transactions[idx])),
                  );
                }
            }

            return const CenteredMessage(message: 'Unknow Error!');
          },
        ));
  }
}
