// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './ExpenseApp.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MaterialApp(
    home: ExpenseApp(),
    title: "Personal Expense",
    theme: ThemeData(
        primarySwatch: Colors.yellow,
        hintColor: Colors.yellowAccent,
        textTheme: ThemeData
            .light()
            .textTheme
            .copyWith(
            titleMedium: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 18,
                fontWeight: FontWeight.bold
            ),

            bodyMedium: TextStyle(
                fontFamily: 'OpenSans', color: Colors.blueGrey),
            labelLarge: TextStyle(
                color: Colors.white
            )

        ),


        appBarTheme: AppBarTheme(titleTextStyle: TextStyle(
            fontSize: 20, fontFamily: 'QuickSand', fontWeight: FontWeight.bold))


    ),


  ));
}


