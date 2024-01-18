import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/models/weather_model.dart';

class WeatherApi extends ChangeNotifier {
  final String _apiKey = '1cff1506c3254e2bab1155627232112';
  final String _baseUrl = 'http://api.weatherapi.com/v1/forecast.json';
  bool istempF = false;
  int index = 0;

  Location? locationData;
  Current? weatherData;
  List<Forecastday>? weatherDetails;
  List<Hour>? hourDays;

  Future<void> getData(String city) async {
    final response = await http.get(
      Uri.parse('$_baseUrl?key=$_apiKey&q=$city&days=3'),
    );

    var jsonString = jsonDecode(response.body);

    locationData = Location.fromJson(jsonString['location']);

    weatherData = Current.fromJson(jsonString['current']);

    List<dynamic> body = jsonString['forecast']['forecastday'];

    weatherDetails = body.map((item) => Forecastday.fromJson(item)).toList();

    List<dynamic> hours = jsonString['forecast']['forecastday'][0]['hour'];

    hourDays = hours.map((item) => Hour.fromJson(item)).toList();
  }

  switchTemp() {
    istempF = !istempF;
    notifyListeners();
  }

  changeIndex(int newIndex) {
    index = newIndex;
    notifyListeners();
  }
}
