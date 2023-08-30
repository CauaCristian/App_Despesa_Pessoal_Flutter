import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';
import 'chartBar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransaction;

  Chart({required this.recentTransaction});

  List<Map<String, Object>> get groupedTransactions {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double totalSum = 0.0;
      for (var i = 0; i < recentTransaction.length; i++) {
        bool sameDay = recentTransaction[i].data.day == weekDay.day;
        bool sameMonth = recentTransaction[i].data.month == weekDay.month;
        bool sameYear = recentTransaction[i].data.year == weekDay.year;

        if (sameDay && sameMonth && sameYear) {
          totalSum += recentTransaction[i].value;
        }
      }
      return {
        "day": DateFormat.E().format(weekDay)[0],
        "value": totalSum,
      };
    }).reversed.toList();
  }

  double get _weekTotalValue {
    return groupedTransactions.fold(0.0, (sum, tr) {
      return sum + (tr["value"] as double);
    });
  }

  double _percentage(Map<String, Object> tr, double weekTotalValue) {
    if (tr["value"] == null) {
      return 0.0;
    }

    double value = tr["value"] as double;

    if (weekTotalValue == 0.0) {
      return 0.0;
    }

    return value / weekTotalValue;
  }

  @override
  Widget build(BuildContext context) {
    groupedTransactions;
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactions.map((tr) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                label: tr["day"].toString(),
                value: double.parse(tr["value"].toString()),
                percentage: _percentage(tr, _weekTotalValue),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
