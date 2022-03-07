import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:simpleweatherapp/models/model.dart';
class WeatherInfo{

 Future<WeatherModels> getWeather(String city) async{

    String apiUrl = 'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=12c3ff510d6fae9811928fdc88b281d4&units=metric';
    var api = Uri.parse(apiUrl);
    var response = await http.get(api);
    var body = jsonDecode(response.body);
    print(body);
    return WeatherModels.fromJson(body);
  }

}