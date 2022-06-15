import 'package:expenses/models/transaction.dart';
import 'package:expenses/widgets/chart_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:math';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final DateTime weekDay = DateTime.now().subtract(Duration(days: index));

      var totalSum = 0.0;

      for (var tx in recentTransactions) {
        if (tx.date.day == weekDay.day && tx.date.month == weekDay.month && tx.date.year == weekDay.year) {
          totalSum += tx.amount;
        }
      }

      print('$weekDay $totalSum');

      return {'day': DateFormat.E('pl_PL').format(weekDay).substring(0, 1), 'amount': totalSum};
    }).reversed.toList();
  }

  double get totalSpending {
    return groupedTransactionValues.fold(0.00, (sum, tx) {
      return sum = sum + (tx['amount'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    print(groupedTransactionValues);
    return Container(
      child: Card(
        elevation: 6,
        margin: EdgeInsets.all(20),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: groupedTransactionValues.map((tx) {
            return Expanded(
              child: ChartBar(
                tx['day'] as String,
                tx['amount'] as double,
                totalSpending == 0.0 ? 0.0 : (tx['amount'] as double) / totalSpending,
              ),
            );
          }).toList()),
        ),
      ),
    );
  }
}
