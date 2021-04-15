import '../models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatelessWidget {
  final Transaction transaction;

  TransactionItem(this.transaction);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: FittedBox(
              child: Text('R\$${transaction.value}'),
            ),
          ),
        ),
        title: Text(
          transaction.title,
          style: Theme.of(context).textTheme.headline6,
        ),
        subtitle: Text(
          DateFormat('dd/MM/yyyy').format(transaction.date),
        ),
      ),
    );
  }
}
// child: Row(
//   children: <Widget>[
//     Container(
//       alignment: Alignment.center,
//       constraints: BoxConstraints(
//         minWidth: 155,
//         maxWidth: 155,
//       ),
//       margin: EdgeInsets.symmetric(
//         horizontal: 15,
//         vertical: 10,
//       ),
//       padding: EdgeInsets.fromLTRB(10, 8, 10, 8),
//       decoration: BoxDecoration(
//         border: Border.all(
//           color: Theme.of(context).primaryColor,
//           width: 2,
//         ),
//       ),
//       child: Text(
//         'R\$ ${transaction.value.toStringAsFixed(2)}',
//         style: TextStyle(
//           fontWeight: FontWeight.bold,
//           fontSize: 20,
//           color: Colors.purple,
//         ),
//       ),
//     ),
//     Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: <Widget>[
//         Text(
//           transaction.title,
//           style: Theme.of(context).textTheme.headline6,
//           // style: TextStyle(
//           //   fontSize: 16,
//           //   fontWeight: FontWeight.bold,
//           // ),
//         ),
//         Text(
//           DateFormat('dd/MM/yyyy').format(transaction.date),
//           style: TextStyle(
//             color: Colors.grey[600],
//           ),
//         )
//       ],
//     )
//   ],
// ),
