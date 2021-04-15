import 'package:expenses/models/transaction.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import './chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentsTransactions;

  Chart(this.recentsTransactions);

  List<Map<String, Object>> get groupTransactions {
    return List.generate(
      7,
      (idx) {
        final DateTime weekDay = DateTime.now().subtract(
          Duration(days: idx),
        );
        final String dayChar = DateFormat.E().format(weekDay)[0];
        double totalSum = 0.0;

        for (int i = 0; i < recentsTransactions.length; i++) {
          bool sameDay = recentsTransactions[i].date.day == weekDay.day;
          bool sameMonth = recentsTransactions[i].date.month == weekDay.month;
          bool sameYear = recentsTransactions[i].date.year == weekDay.year;

          if (sameDay && sameMonth && sameYear) {
            totalSum += recentsTransactions[i].value;
          }
        }

        return {'day': dayChar, "value": totalSum};
      },
    ).reversed.toList();
  }

  double get _weekSum {
    return groupTransactions.fold(0, (acu, tr) {
      //fold é o reduce do js, primeiro paramero é o valor inicial
      return acu + tr['value'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupTransactions.map((transaction) {
            final double percentage =
                (transaction['value'] as double) / _weekSum;
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                label: transaction['day'],
                value: transaction['value'],
                percentage: percentage,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
