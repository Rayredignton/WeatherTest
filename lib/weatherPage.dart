import 'package:WeatherApp/login.dart';
import 'package:WeatherApp/weather.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShowWeather extends StatefulWidget {
  final String controller;
  ShowWeather({Key key, this.controller}) : super(key: key);
  @override
  _ShowWeatherState createState() => _ShowWeatherState();
}

class _ShowWeatherState extends State<ShowWeather> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  WeatherResponse weatherResponse;
  SharedPreferences _preferences;
  void signOutGoogle() async {
    await _googleSignIn.signOut();
    print("User Sign Out");
  }

  @override
  void initState() {
    super.initState();
    getSharedPreferences();
  }

  getSharedPreferences() async {
    _preferences = await SharedPreferences.getInstance();
    getWeatherData(_preferences.getString('city'));
  }

  getWeatherData(String city) async {
    final response = await http.get(
        'https://api.openweathermap.org/data/2.5/weather?q=$city&appid');

    if (response.statusCode == 200) {
      setState(() {
        weatherResponse = WeatherResponse.fromJSON(jsonDecode(response.body));
      });
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  void fetchLocationDay(String city) async {
    var today = new DateTime.now();
    for (var i = 0; i < 7; i++) {
      var dayResult = await http.get(
          'https://api.openweathermap.org/data/2.5/forecast?q=$city&appid=a91f7b3505c38451c5963e99bbc49282' +
              '/' +
              new DateFormat('y/M/d')
                  .format(today.add(new Duration(days: i + 1)))
                  .toString());
      var result = json.decode(dayResult.body);
      var data = result[0];
    }
  }
    @override
    Widget build(BuildContext context) {
      return SafeArea(
        child: Material(
            color: Colors.blue,
            // padding: EdgeInsets.only(right: 32, left: 32, top: 10),
            child: Column(
              children: <Widget>[
                Center(
                    child: Container(
                  child: FlareActor(
                    "assets/WorldSpin.flr",
                    fit: BoxFit.contain,
                    animation: "roll",
                  ),
                  height: 300,
                  width: 300,
                )),
                Text(
                  DateFormat('EEEE, d MMMM yyyy').format(DateTime.now()),
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Clouds",
                        style: TextStyle(color: Colors.white70, fontSize: 30),
                      ),
                      Text(
                        weatherResponse.clouds.round().toString() + "%",
                        style: TextStyle(color: Colors.white70, fontSize: 30),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Min Temp",
                        style: TextStyle(color: Colors.white70, fontSize: 30),
                      ),
                      Text(
                        weatherResponse.tempmin.round().toString() + "C",
                        style: TextStyle(color: Colors.white70, fontSize: 30),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Max Temp",
                        style: TextStyle(color: Colors.white70, fontSize: 30),
                      ),
                      Text(
                        weatherResponse.tempmax.round().toString() + "C",
                        style: TextStyle(color: Colors.white70, fontSize: 30),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Humidity",
                        style: TextStyle(color: Colors.white70, fontSize: 30),
                      ),
                      Text(
                        weatherResponse.humidity.round().toString() + "%",
                        style: TextStyle(color: Colors.white70, fontSize: 30),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Pressure",
                        style: TextStyle(color: Colors.white70, fontSize: 30),
                      ),
                      Text(
                        weatherResponse.pressure.round().toString(),
                        style: TextStyle(color: Colors.white70, fontSize: 30),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Wind Speed",
                        style: TextStyle(color: Colors.white70, fontSize: 30),
                      ),
                      Text(
                        weatherResponse.windSpeed.round().toString() + "Km/h",
                        style: TextStyle(color: Colors.white70, fontSize: 30),
                      ),
                    ],
                  ),
                ),
                RaisedButton(
                  onPressed: () {
                    signOutGoogle();
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) {
                      return LoginScreen();
                    }), ModalRoute.withName('/'));
                  },
                  color: Colors.black,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Sign Out',
                      style: TextStyle(fontSize: 25, color: Colors.white),
                    ),
                  ),
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40)),
                )
              ],
            )),
      );
    }
  }

