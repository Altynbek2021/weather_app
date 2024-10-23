import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'dart:convert';

class Location {
  double latitude = 0.0;
  double longitude = 0.0;

  Future<void> getCurrentLocation() async {
    final LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.low,
      distanceFilter: 100,
    );
    try {
      Position position = await Geolocator.getCurrentPosition(
          locationSettings: locationSettings);
      latitude = position.latitude;
      longitude = position.longitude;
    } catch (e) {
      print(e);
    }
  }

  Future<void> getData() async {
    final myKey = "f7bf10e3cff206d1c04627b69a590dd6";

    var response = await get(Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$myKey"));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      String data = response.body;
      var decodedData = jsonDecode(data);

      String cityName = decodedData["name"];
      double temperature = decodedData["main"]["temp"];
      int condition = decodedData["weather"][0]['id'];
      print(response.body);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }
}
