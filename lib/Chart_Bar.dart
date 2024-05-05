// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class Bars extends StatelessWidget {
  const Bars(
      {super.key,
      required this.label,
      required this.spends,
      required this.totalAmountSpends});

  final String label;
  final double spends;
  final double totalAmountSpends;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: LayoutBuilder(
        builder: (context,constraints)
          {
            return Column(
              children: [
                Container(height: constraints.maxHeight * 0.15, child: FittedBox(child: Text("\$$spends"))),
                SizedBox(
                  height:  constraints.maxHeight * 0.05,
                ),
                Stack(
                  children: [
                    Container(
                      height:  constraints.maxHeight  * 0.6,
                      width: 10,
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(220, 220, 220, 1),
                          border: Border.all(color: Colors.blue),
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    SizedBox(
                      height: constraints.maxHeight * 0.05,
                    ),
                    Container(
                      height:  constraints.maxHeight  * 0.6,
                      width: 10,
                      child: FractionallySizedBox(
                        heightFactor: totalAmountSpends,
                        child: Container(
                            decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                border: Border.all(color: Colors.blue),
                                borderRadius: BorderRadius.circular(50))),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height:  constraints.maxHeight * 0.05,
                ),
                Container(
                  height:  constraints.maxHeight* 0.15,
                  child: Text(
                    label,
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            );
          }

      ),
    );
  }
}
