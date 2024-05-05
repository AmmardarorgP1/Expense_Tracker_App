// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'Model/Class/transactionClass.dart';

class UserTransactions extends StatelessWidget {
  const UserTransactions(
      {super.key, required this.transaction, required this.deleteTx});

  final List<Transaction> transaction;
  final Function deleteTx;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery
          .of(context)
          .size
          .height,
      child: transaction.isEmpty
          ? Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "No transactions Added yet!!!",
            style: Theme
                .of(context)
                .textTheme
                .titleMedium,
          ),
          SizedBox(
            height: 20,
          ),
          Container(
              height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.4,
              child: Image.asset(
                "assets/images/waiting.png",
              )),
        ],
      )
          : ListView.builder(
        itemBuilder: (context, index) {
          return Container(
            height: 100,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: 3.0, horizontal: 4.0),
              child: Card(
                elevation: 5,
                margin: EdgeInsets.all(2),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.blue,
                    child: Padding(
                        padding: EdgeInsets.all(6.0),
                        child: FittedBox(
                            child: Text(
                              "\$${transaction[index].amount.toStringAsFixed(
                                  2)}",
                              style: TextStyle(
                                  color: Colors.black, fontSize: 14),
                            ))),
                  ),
                  title: Text(transaction[index].name,
                      style: Theme
                          .of(context)
                          .textTheme
                          .titleMedium),
                  subtitle: Text(
                    DateFormat.yMMMd().format(transaction[index].time),
                    style: Theme
                        .of(context)
                        .textTheme
                        .bodyMedium,
                  ),
                  trailing: MediaQuery
                      .of(context)
                      .size
                      .width > 400 ? TextButton.icon(onPressed: () {
                    deleteTx(transaction[index].id);
                  }, icon:Icon(
                    Icons.delete_rounded,
                    color: Colors.red,
                  ), label: Text("Delete"))
                      : IconButton(
                      onPressed: () {
                        deleteTx(transaction[index].id);
                      },
                      icon: Icon(
                        Icons.delete_rounded,
                        color: Colors.red,
                      )),
                ),
              ),
            ),
          );
        },
        itemCount: transaction.length,
      ),
    );
  }
}
