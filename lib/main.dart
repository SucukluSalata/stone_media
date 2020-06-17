import 'package:flutter/material.dart';
import 'package:stonemedia/ui/HomePage.dart';
import 'package:stonemedia/ui/StoneTech.dart';
import 'package:stonemedia/ui/StoneTechBook.dart';
import 'package:stonemedia/ui/StoneWorld.dart';
import 'package:stonemedia/ui/StoneWorldBook.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/",
      routes: {
        "/": (context) => MyHomePage(),
        "/StoneWorldHome": (context) => StoneWorldHome(),
        "/StoneWorldBook": (context) => StoneWorldBook(),
        "/StoneTechHome": (context) => StoneTechHome(),
        "/StoneTechBook": (context) => StoneTechBook(),
      },
      title: 'StoneMedia',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}
