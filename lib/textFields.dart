// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:expense_app/UserTransactions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'Model/Class/transactionClass.dart';

class UserTransaction extends StatefulWidget {
  const UserTransaction({super.key, required this.trans, required this.addTx});

  final List<Transaction> trans;
  final Function addTx;

  @override
  State<UserTransaction> createState() => _UserTransactionState();
}

class _UserTransactionState extends State<UserTransaction> {
  final _nameController = TextEditingController();
  final _amountController = TextEditingController();
   DateTime? _selectedDate;

  void _selectDate() {

    showDatePicker(
            context: context,
            firstDate: DateTime(2019),
            lastDate: DateTime.now(),
            initialDate: DateTime.now())
        .then((value) {
      if (value == null) {

        return;
      } else {
        setState(() {
          _selectedDate = value;
        });
      }
    });
  }

  void addTransaction() {
    if (_nameController.text.isEmpty || _amountController.text.isEmpty|| _selectedDate == null) {
      Navigator.pop(context);
      final snackBar = SnackBar(
        backgroundColor: Colors.red,
        content: Text("Please Fill all fields"),
        duration: Duration(seconds: 3),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      return;
    }
    String name = _nameController.text;
    double amount = double.parse(_amountController.text);

    widget.addTx(name, amount,_selectedDate);

    _amountController.clear();
    _nameController.clear();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final landOrientation = MediaQuery.of(context).orientation == Orientation.landscape;

    return landOrientation ? Padding(
      padding:  EdgeInsets.only(top: 8.0,left:8.0 , right: 8.0,bottom: MediaQuery.of(context).viewInsets.bottom + 20.0 ),
      child: Card(
        elevation: 5,
        surfaceTintColor: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Name',
                ),
                controller: _nameController,
                // autofocus: true,

                onSubmitted: (_) {
                  addTransaction();
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                  decoration: InputDecoration(labelText: 'Amount'),
                  controller: _amountController,
                  keyboardType: TextInputType.numberWithOptions(),
                  onSubmitted: (_) {
                    addTransaction();
                  }),
            ),
            Row(
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      _selectedDate != null
                          ? DateFormat.yMd().format(_selectedDate!)
                          : "Choose a Date!",
                      style: TextStyle(color: Colors.blueGrey),
                    )),
                TextButton(
                    onPressed: _selectDate,
                    child: Text("Choose",
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 16)))
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                          Theme.of(context).primaryColor),
                      foregroundColor: MaterialStatePropertyAll(Colors.white)),
                  onPressed: () {
                    addTransaction();
                  },
                  child: Text(
                    "Add Transaction",
                  )),
            ),
          ],
        ),
      ),
    ):Card(
      elevation: 5,
      surfaceTintColor: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Name',
              ),
              controller: _nameController,
              // autofocus: true,

              onSubmitted: (_) {
                addTransaction();
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                controller: _amountController,
                keyboardType: TextInputType.numberWithOptions(),
                onSubmitted: (_) {
                  addTransaction();
                }),
          ),
          Row(
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    _selectedDate != null
                        ? DateFormat.yMd().format(_selectedDate!)
                        : "Choose a Date!",
                    style: TextStyle(color: Colors.blueGrey),
                  )),
              TextButton(
                  onPressed: _selectDate,
                  child: Text("Choose",
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 16)))
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(
                        Theme.of(context).primaryColor),
                    foregroundColor: MaterialStatePropertyAll(Colors.white)),
                onPressed: () {
                  addTransaction();
                },
                child: Text(
                  "Add Transaction",
                )),
          ),
        ],
      ),
    );
  }
}
