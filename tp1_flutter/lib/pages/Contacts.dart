import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class Contacts extends StatefulWidget{
  @override
  State<Contacts> createState() => _ContactsState();
}

class _ContactsState extends State<Contacts> {
  TextEditingController textController = new TextEditingController();
  List<String> data = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contacts"),
      ),
      body: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Row(children: [
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.contacts),
                      hintText: "entrer un nom",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)
                      )
                    ),
                    controller: textController,
                  ),
                ),
                IconButton(onPressed: () {
                  setState(() {
                    data.add(textController.text);
                  });
                }, icon: Icon(Icons.add))
              ]
              ),
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index){
                    return ListTile(
                      leading: CircleAvatar(child: Text(data[index].substring(0,1)),),
                      title: Text(data[index]),
                    );
                  },
                  itemCount: data.length
                ),
              )
            ],
          )
      ),
    );
  }
}