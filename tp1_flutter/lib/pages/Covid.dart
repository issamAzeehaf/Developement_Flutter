import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class Covid extends StatefulWidget {
  @override
  State<Covid> createState() => _CovidState();
}

class _CovidState extends State<Covid> {
  var stats;
  var data;
  String keyword = "Morocco";

  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      textEditingController.text = "Morocco";
      getStats();
      searchCountry("Morocco");
    });
  }

  getStats() {
    String url = "https://covid-api.mmediagroup.fr/v1/cases";
    http.get(Uri.parse(url)).then((response) {
      setState(() {
        Map _json = json.decode(response.body);
        data=[];
        _json.values.forEach((element) {
          if( element!=null && element["All"]!=null ) {
            data.add(element);
          }
        });
        searchCountry(keyword);
      });
    }).catchError((onError) {
      print("Error while calling the api ==> " + onError.toString());
      Fluttertoast.showToast(
          msg: "Can't query data with Covid-19 Api !",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.SNACKBAR,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    });
  }

  void searchCountry(String keyword) {
    if( data !=null && (data as List).isNotEmpty) {
      stats = [];
      (data as List).forEach((element) {
        if (
        element["All"]["country"].toString().toLowerCase().contains(keyword.toLowerCase())
            ||
            element["All"]["abbreviation"].toString().toLowerCase().contains(keyword.toLowerCase())
        ) {
          (stats as List).add(element);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Covid-19 stats per country"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                    flex: 6,
                    child: TextFormField(
                      controller: textEditingController,
                      onChanged: (value) {
                        setState(() {
                          keyword = value;
                          searchCountry(keyword);
                        });
                      },
                      decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          )),
                    )),
                Expanded(
                    child: IconButton(
                      onPressed: () {
                        getStats();
                      },
                      icon: const Icon(Icons.refresh, color: Colors.deepOrange),
                    )),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 20, left: 8, right: 8, bottom: 20),
                child: ListView.builder(
                  itemCount: stats == null ? 0 : stats.length,
                  itemBuilder: (context, index) {
                    String country = stats[index]["All"]["country"].toString(),
                        confirmed = stats[index]["All"]["confirmed"].toString(),
                        recovered = stats[index]["All"]["recovered"].toString(),
                        deaths = stats[index]["All"]["deaths"].toString(),
                        abbreviation = stats[index]["All"]["abbreviation"]
                            .toString()
                            .toLowerCase(),
                        updated = stats[index]["All"]["updated"]
                            .toString()
                            .toLowerCase();

                    updated = updated.split(" ")[0];

                    return Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                          child: ListTile(
                              leading: ConstrainedBox(
                                constraints: const BoxConstraints(
                                  minWidth: 44,
                                  minHeight: 44,
                                  maxWidth: 50,
                                  maxHeight: 50,
                                ),
                                child: Image.asset(
                                    'icons/flags/png/' + abbreviation + '.png',
                                    package: 'country_icons',
                                    fit: BoxFit.cover),
                              ),
                              title: Padding(
                                padding:
                                const EdgeInsets.only(bottom: 8, top: 4),
                                child: Title(
                                    title: country,
                                    child: Text(country,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    color: Colors.black),
                              ),
                              subtitle: Padding(
                                padding: const EdgeInsets.only(bottom: 4),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                            child: Text(
                                                "Confirmed : " + confirmed,
                                                style: const TextStyle(
                                                    color: Colors.orange))),
                                        Expanded(
                                            child: Text(
                                                "Recovered : " + recovered,
                                                style: const TextStyle(
                                                    color: Colors.green))),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                            child: Text("Deaths : " + deaths,
                                                style: const TextStyle(
                                                    color: Colors.red)))
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                            child: Wrap(children: [
                                              const Text("Updated : "),
                                              Text(updated,
                                                  style: const TextStyle(
                                                      color: Colors.deepPurple))
                                            ]))
                                      ],
                                    )
                                  ],
                                ),
                              )),
                        ),
                      ),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}