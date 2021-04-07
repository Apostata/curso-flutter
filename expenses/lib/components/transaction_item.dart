import '../models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatelessWidget {
  final Transaction transaction;

  TransactionItem(this.transaction);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            constraints: BoxConstraints(
              minWidth: 155,
              maxWidth: 155,
            ),
            margin: EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 10,
            ),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.purple[300], width: 2),
            ),
            child: Text(
              'R\$ ${transaction.value.toStringAsFixed(2)}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.purple,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                transaction.title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                DateFormat('dd/MM/yyyy').format(transaction.date),
                style: TextStyle(
                  color: Colors.grey[600],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
