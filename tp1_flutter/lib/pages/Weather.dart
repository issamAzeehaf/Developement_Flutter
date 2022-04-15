import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../providers/Provider.dart';

class Weather extends StatelessWidget {
  String city = "Taza";

  @override
  Widget build(BuildContext context) {

    getData(String city) {
      String url = "https://goweather.herokuapp.com/weather/" + city;
      http.get(Uri.parse(url)).then((response) {
        Map _json = json.decode(response.body);
        Provider.of<WeatherDataProvider>(context, listen: false).setData(_json);
      }).catchError((onError) {
        print("Error while calling the api ==> " + onError.toString());
        Fluttertoast.showToast(
            msg: "Can't query data with Weather Api !",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.SNACKBAR,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      });
    }

    getData(city);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Weather (state provider)"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(children: [
          Row(
            children: [
              Expanded(
                flex: 6,
                child: DropdownButtonFormField<String>(
                  value: city,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    prefixIcon: const Icon(Icons.location_on_outlined,
                        color: Colors.deepOrange),
                  ),
                  hint: const Text('Please choose a city'),
                  items: <String>[
                    'taza',
                    'Mohammedia',
                    'Rabat',
                    'Berlin',
                    'Moscow',
                    'Tokyo',
                    'Istanbul'
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    city = value!;
                    getData(city);
                  },
                ),
              ),
            ],
          ),
          Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 10),
              child: Consumer<WeatherDataProvider>(
                  builder: (context, weatherState, chid) {
                    if (weatherState.data == null) {
                      return Container();
                    }
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 36, bottom: 30, left: 9, right: 9),
                        child: Column(
                          children: [
                            Title(
                                color: Colors.black,
                                child: Text(
                                  "Weather in : " + city.toUpperCase(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w900, fontSize: 18),
                                )),
                            Padding(
                              padding: const EdgeInsets.only(top: 30, bottom: 18),
                              child: Center(
                                child: Column(
                                  children: [
                                    Text(
                                      weatherState.data["temperature"]
                                          .toString().replaceAll("Â", "") ,
                                      style: const TextStyle(
                                          fontSize: 65, color: Colors.deepPurple, fontWeight: FontWeight.w100),
                                    ),
                                    Text(
                                      weatherState.data["wind"].toString(),
                                      style: const TextStyle(
                                          fontSize: 65, color: Colors.deepPurple, fontWeight: FontWeight.w100),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Text( weatherState.data["description"].toString(),
                                          style: const TextStyle(fontWeight: FontWeight.w200, fontSize: 30, color: Colors.blue)
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only( top: 40, bottom: 20),
                              child: Center(
                                child: Column(
                                  children: [
                                    Text(" day 1 :   "+weatherState.data["forecast"][0]["temperature"].toString().replaceAll("Â", "") +
                                        "  |  " + weatherState.data["forecast"][0]["wind"].toString(),
                                        style: const TextStyle( color: Colors.deepOrange, fontSize: 18)
                                    ),
                                    Padding(
                                        padding: const EdgeInsets.only( top:20, bottom: 20),
                                        child: Text(" day 2 :   "+weatherState.data["forecast"][1]["temperature"].toString().replaceAll("Â", "") +
                                            "  |  " + weatherState.data["forecast"][1]["wind"].toString(),
                                            style: const TextStyle( color: Colors.deepOrange, fontSize: 18)
                                        )
                                    ),
                                    Text(" day 3 :   "+weatherState.data["forecast"][2]["temperature"].toString().replaceAll("Â", "") +
                                        "  |  " + weatherState.data["forecast"][2]["wind"].toString(),
                                        style: const TextStyle( color: Colors.deepOrange, fontSize: 18)
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }))
        ]),
      ),
    );
  }
}