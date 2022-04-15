

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(child: Column(
            children: [
              CircleAvatar(
                backgroundImage: AssetImage("images/profil.jpeg"),
                radius: 50,
              ),
              SizedBox(height: 10,),
              Text("AZEHAF Issam"),
            ],
          )),
          ListTile(
            onTap: (){
              Navigator.pushNamed(context, "/");
            },
            leading: Icon(
              Icons.home,
              color: Colors.orange,
            ),
            title: Text(
              "Home",
              style: TextStyle(fontSize: 20, color: Colors.orange),
            ),
          ),
          ListTile(
            onTap: (){
              Navigator.pop(context);
              Navigator.pushNamed(context, "/contacts");
            },
            leading: Icon(
              Icons.contacts,
              color: Colors.orange,
            ),
            title: Text(
              "Contacts",
              style: TextStyle(fontSize: 20, color: Colors.orange),
            ),
          ),
          ListTile(
            onTap: (){
              Navigator.pop(context);
              Navigator.pushNamed(context, "/covid");
            },
            leading: Icon(
              Icons.newspaper,
              color: Colors.orange,
            ),
            title: Text(
              "News Covid",
              style: TextStyle(fontSize: 20, color: Colors.orange),
            ),
          ),
          ListTile(
            onTap: (){
              Navigator.pop(context);
              Navigator.pushNamed(context, "/weather");
            },
            leading: Icon(
              Icons.newspaper,
              color: Colors.orange,
            ),
            title: Text(
              "News Weather",
              style: TextStyle(fontSize: 20, color: Colors.orange),
            ),
          )
        ],
      ),
    );
  }

}