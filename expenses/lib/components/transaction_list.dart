import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import './transaction_item.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final void Function(String) _deleteTransaction;

  TransactionList(this.transactions, this._deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(builder: (ctx, constraints) {
            return Column(
              children: <Widget>[
                SizedBox(height: constraints.maxHeight * 0.05),
                Container(
                  height: constraints.maxHeight * 0.15,
                  child: Text(
                    'Nenuma transação cadastrada!',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                SizedBox(height: constraints.maxHeight * 0.02),
                Container(
                  height: constraints.maxHeight * 0.67,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                )
              ],
            );
          })
        : ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (ctx, idx) {
              final transaction = transactions[idx];
              return TransactionItem(
                // key: GlobalObjectKey(
                //     //GlobalObjectKey chava unica dentro do listView para apenas listItems que seja StateFull
                //     transaction
                key: ValueKey(transaction.id),
                
                transaction: transaction,
                deleteTransaction: _deleteTransaction,
              );
            },
          );
    // ListView(
    //   children: transactions.map((transaction) {
    //     return TransactionItem(
    //       key: ValueKey(transaction.id), //ValeuKey chava unica dentro do listView
    //       transaction: transaction,
    //       deleteTransaction: _deleteTransaction,
    //     );
    //   }).toList(),
    // );
  }
}
