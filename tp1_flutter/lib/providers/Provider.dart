import 'package:flutter/cupertino.dart';

class WeatherDataProvider extends ChangeNotifier {

  var data;

  void setData(var data) {
    this.data = data;
    notifyListeners();
  }
}