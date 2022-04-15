
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tp1_flutter/widgets/App_Drawer.dart';

class Home extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text("TP 1 Flutter"),
      ),
      body: Center(
        child: ElevatedButton(
            onPressed: (){
              Navigator.pushNamed(context, "/contacts");
            },
            child: Text("Contacts")
        ),
      ),
    );
  }

}