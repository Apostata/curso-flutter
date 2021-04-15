// import 'package:flutter/material.dart';

// class TransactionUser extends StatefulWidget {
//   @override
//   _TransactionUserState createState() => _TransactionUserState();
// }

// class _TransactionUserState extends State<TransactionUser> {
//   _addTransaction(String title, double value) {
//     final newTransaction = Transaction(
//       id: Random().nextDouble().toString(),
//       title: title,
//       value: value,
//       date: DateTime.now(),
//     );

//     setState(() {
//       _transactions.add(newTransaction);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         TransactionForm(_addTransaction),
//         TransactionList(_transactions),
//       ],
//     );
//   }
// }
