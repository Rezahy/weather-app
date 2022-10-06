import 'package:http/http.dart' as http;
import 'package:weather_app/constants.dart';
import 'dart:convert' as convert;

class Network {
  static Future<Map<String, dynamic>?> getCityId(String city) async {
    try {
      var response = await http.get(Uri.parse(
          '$BASE_URL/locations/v1/cities/search?apikey=$API_KEY&q=$city'));
      print(response.statusCode);
      if (response.statusCode == 200) {
        var responseBody = convert.json.decode(response.body) as List;
        var data = responseBody[0] as Map<String, dynamic>;
        return data;
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  static Future<Map<String, dynamic>?> getWeatherInfo(String cityId) async {
    try {
      var response = await http.get(
          Uri.parse('$BASE_URL/currentconditions/v1/$cityId?apikey=$API_KEY'));
      if (response.statusCode == 200) {
        var responseBody = convert.json.decode(response.body) as List;
        var data = responseBody[0] as Map<String, dynamic>;
        return data;
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }
}
