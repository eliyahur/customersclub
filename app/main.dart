import 'package:flutter/material.dart';
import './myHomePage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Customer Club App',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: MyHomePage());
  }
}







