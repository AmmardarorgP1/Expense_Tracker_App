  // ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables, prefer_const_literals_to_create_immutables

  import 'package:expense_app/Chart_Bar.dart';
  import 'package:expense_app/Model/Class/transactionClass.dart';
  import 'package:flutter/material.dart';
  import 'package:intl/intl.dart';

  class Chart extends StatelessWidget {
    const Chart({super.key, required this.recentTransactions});

    final List<Transaction> recentTransactions;

    List<Map<String, Object>> get groupedTransactions {
      return List.generate(7, (index) {
        final weekDay = DateTime.now().subtract(Duration(days: index));
        var amount = 0.0;
        for (int i = 0; i < recentTransactions.length; i++) {
          if (recentTransactions[i].time.day == weekDay.day &&
              recentTransactions[i].time.month == weekDay.month &&
              recentTransactions[i].time.year == weekDay.year) {
            amount += recentTransactions[i].amount;
          }
        }
        return {
          "day": DateFormat.E().format(weekDay).substring(0, 3),
          "total": amount
        };
      }).reversed.toList();
    }

    double get totalSpending {
      return groupedTransactions.fold(0.0, (sum, tx) {
        return sum + (tx["total"] as double);
      });
    }

    @override
    Widget build(BuildContext context) {
      print(groupedTransactions);
      return Padding(
        padding: const EdgeInsets.all(6.0),
        child: Card(
          elevation: 4,

          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: groupedTransactions.map((tx) {
                  return Bars(
                      label: tx["day"].toString(),
                      spends: (tx["total"] as double),
                      totalAmountSpends: totalSpending == 0.0
                          ? 0.0
                          : (tx["total"] as double) / totalSpending);
                }).toList()),
          ),
        ),
      );
    }
  }
