import 'package:flutter/material.dart';
import 'package:tp1_flutter/pages/Contacts.dart';
import 'package:tp1_flutter/pages/Covid.dart';
import 'package:tp1_flutter/pages/Weather.dart';
import 'package:tp1_flutter/pages/home.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.orange,
        textTheme: TextTheme(
          //bodyText1: TextStyle(color: Colors.grey)
        )
      ),
      routes: {
        "/":(context) => Home(),
        "/contacts":(context)=>Contacts(),
        "/covid":(context) => Covid(),
        "/weather":(context) => Weather(),
      },
    );
  }

}