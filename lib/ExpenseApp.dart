// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:ffi';

import 'package:expense_app/Chart.dart';
import 'package:expense_app/UserTransactions.dart';
import 'package:expense_app/textFields.dart';
import 'package:flutter/material.dart';

import 'Model/Class/transactionClass.dart';

class ExpenseApp extends StatefulWidget {
  const ExpenseApp({super.key});

  @override
  State<ExpenseApp> createState() => _ExpenseAppState();
}

class _ExpenseAppState extends State<ExpenseApp> {
  final List<Transaction> _transactions = [
    // Transaction("Aj", "T1", 1.00, DateTime.now()),
    // Transaction("Bale", "T2", 2.00, DateTime.now()),
  ];

  List<Transaction> get recentTransactions {
    return _transactions.where((tx) {
      return tx.time.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _deleteTransaction(String id) {
    setState(() {
      _transactions.removeWhere((tx) => tx.id == id);
    });
  }

  void addTransactionState(String name, double amount, DateTime dateTime) {
    setState(() {
      _transactions
          .add(Transaction(name, DateTime.now().toString(), amount, dateTime));

      print("added successfully");
    });
  }

  void openNewTransPanel(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return UserTransaction(
          trans: _transactions,
          addTx: addTransactionState,
        );
      },
    );
  }

  bool _showChart = false;

  @override
  Widget build(BuildContext context) {
    final landscapeOrientation =
        MediaQuery.of(context).orientation == Orientation.landscape;
    print('this is main');
    print(recentTransactions);
    final appbar = AppBar(
      title: const Text(
        "Expense App",
        style: TextStyle(color: Colors.white),
      ),
      actions: [
        IconButton(
            onPressed: () {
              openNewTransPanel(context);
            },
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ))
      ],
      backgroundColor: Theme.of(context).primaryColor,
      centerTitle: true,
    );
    final txInColumn = Container(
      height: (MediaQuery.of(context).size.height -
              appbar.preferredSize.height -
              MediaQuery.of(context).padding.top) *
          0.8,
      child: UserTransactions(
        transaction: _transactions,
        deleteTx: _deleteTransaction,
      ),
    );
    return Scaffold(
      appBar: appbar,
      body: ListView(
        children: <Widget>[
          // Card(
          //   elevation: 10,
          //   child: Chart(recentTransactions: recentTransactions)
          // ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              if (landscapeOrientation)
                Text(
                  "Chart",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              if (landscapeOrientation)
                Switch(
                  activeColor: Theme.of(context).hintColor,
                  value: _showChart,
                  onChanged: (value) {
                    setState(() {
                      _showChart = value;
                    });
                  },
                )
            ],
          ),
          if (!landscapeOrientation)
            Container(
                height: (MediaQuery.of(context).size.height -
                        appbar.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    0.2,
                child: Chart(recentTransactions: recentTransactions)),

          if (!landscapeOrientation) txInColumn,

          if (landscapeOrientation)
            _showChart
                ? Container(
                    height: (MediaQuery.of(context).size.height -
                            appbar.preferredSize.height -
                            MediaQuery.of(context).padding.top) *
                        0.7,
                    child: Chart(recentTransactions: recentTransactions))
                : txInColumn,
        ],
      ),
      //floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            openNewTransPanel(context);
          },
          backgroundColor: Theme.of(context).hintColor,
          child: Icon(
            Icons.add,
            size: 35,
          )),
    );
  }
}
