import 'dart:ffi';

import 'package:expense_planner/models/transaction.dart';
import 'package:expense_planner/widgets/chart_bar.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> groupedTransactionsValues() {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      var totalAmountSum = 0.0;

      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].dateTime.day == weekDay.day &&
            recentTransactions[i].dateTime.month == weekDay.month &&
            recentTransactions[i].dateTime.year == weekDay.year) {
          totalAmountSum += recentTransactions[i].amount;
        }
      }
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalAmountSum,
      };
    }).reversed.toList();
  }

  double get maxSpending {
    return groupedTransactionsValues()
        .fold(0.0, (sum, item) => sum += item['amount'] as double);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      margin: EdgeInsets.all(7),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: groupedTransactionsValues()
                .map(
                  (data) => Flexible(
                    fit: FlexFit.tight,
                    child: ChartBar(
                        label: (data['day'] as String),
                        amountSpent: data['amount'] as double,
                        percentageOfTotal: maxSpending == 0.0
                            ? 0.0
                            : (data['amount'] as double) / maxSpending),
                  ),
                )
                .toList()),
      ),
    );
  }
}
