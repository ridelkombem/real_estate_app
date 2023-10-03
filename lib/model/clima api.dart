import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future getCityData() async {
  var url = Uri.parse(
      "https://api.openweathermap.org/data/2.5/weather?q=Princeton&appid=ca817aa49385ce8a8498875e7666fc4a&units=metric");
  var response = await http.get(url);

  if (response.statusCode == 200) {
    print(response.body);
    var cityData = jsonDecode(response.body);

    return cityData;
  } else {
    print("${response.statusCode}for city");
    throw 'An error occured';
  }
}

Future getLocationData() async {
  var url = Uri.parse(
      "https://api.openweathermap.org/data/2.5/weather?lat=44.34&lon=10.99&appid=ca817aa49385ce8a8498875e7666fc4a&units=metric");
  var response = await http.get(url);

  if (response.statusCode == 200) {
    print(response.body);
    var locationData = jsonDecode(response.body);
    return locationData;
  } else {
    print("${response.statusCode}for location");
    throw 'An error occured';
  }
}

class ShowScreen extends StatefulWidget {
  const ShowScreen({super.key});

  @override
  State<ShowScreen> createState() => _ShowScreenState();
}

class _ShowScreenState extends State<ShowScreen> {
  double temp = 0.0;
  int condition = 0;
  String cityName = '';

  getSecondData() async {
    try {
      var cityData = await getCityData();
      if (cityData != null) {
        setState(() {
          var temperature = cityData['main']['temp'];
          temp = temperature;
          var condn = cityData['weather'][0]['id'];
          condition = condn;
        });
      }
    } catch (e) {}
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }

  @override
  void initState() {
    getSecondData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Row(
            children: [
              Text(temp.toStringAsFixed(2)),
              Text(getWeatherIcon(condition))
            ],
          ),
          Text(getMessage(temp.toInt())),
          Container(
            child: Center(
              child: Container(
                height: 100,
                color: Colors.blue,
                child: TextButton(
                    onPressed: () {
                      getCityData();
                      // getLocationData();
                    },
                    child: Text('data')),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
