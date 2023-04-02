import 'package:clima/screens/city_screen.dart';
import 'package:clima/services/weather.dart';
import 'package:clima/utilities/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LocationScreen extends StatefulWidget {
  final locationWeather;

  LocationScreen({this.locationWeather});

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  int temp;
  String city, weatherIcon, message, description, countryCode;
  Duration timeBeforeSunset, timeBeforeSunrise;
  WeatherModel model = WeatherModel();

  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic data) {
    setState(() {
      if (data == null) {
        temp = 0;
        weatherIcon = "Error";
        message = "Unable to get weather data";
        description = "";
        city = "";
        countryCode = "";
        timeBeforeSunrise = Duration();
        timeBeforeSunset = Duration();
        return;
      }

      temp = (data["main"]["temp"] as double).floor();
      weatherIcon = model.getWeatherIcon(data["weather"][0]["id"]);
      message = model.getMessage(temp);
      description = data["weather"][0]["description"];
      city = data["name"];
      countryCode = data["sys"]["country"];
      DateTime now = DateTime.now().toUtc();
      DateTime sunrise = DateTime.fromMillisecondsSinceEpoch(
        data["sys"]["sunrise"] * 1000,
        isUtc: true,
      );
      DateTime sunset = DateTime.fromMillisecondsSinceEpoch(
        data["sys"]["sunset"] * 1000,
        isUtc: true,
      );
      timeBeforeSunrise = now.difference(sunrise);
      timeBeforeSunset = now.difference(sunset);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/location_background.jpg'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.5),
                BlendMode.dstATop,
              )),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  MaterialButton(
                    onPressed: () async {
                      var data = await model.getLocationWeather();
                      updateUI(data);
                    },
                    child: Icon(Icons.near_me, size: 50.0),
                  ),
                  MaterialButton(
                    onPressed: () async {
                      var typedCity = await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CityScreen()),
                      );

                      if (typedCity != null) {
                        var data = await model.getCityWeather(typedCity);
                        updateUI(data);
                      }
                    },
                    child: Icon(Icons.location_city, size: 50.0),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(weatherIcon, style: kConditionTextStyle),
                  Row(
                    children: [
                      Text(temp.toString(), style: kTempValueTextStyle),
                      SizedBox(width: 10.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: kTempUnitBoxDecoration,
                            child: Text("O", style: kTempUnitTextStyle),
                          ),
                          Text("now", style: kTempSubTextStyle),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Text(
                      "$message",
                      textAlign: TextAlign.right,
                      style: kMessageTextStyle,
                    ),
                    SizedBox(height: 10.0),
                    Text.rich(
                      TextSpan(
                          text: "There's $description in ",
                          style: kDescriptionTextStyle,
                          children: [
                            TextSpan(
                                text: "$city, $countryCode",
                                style: TextStyle(fontStyle: FontStyle.italic))
                          ]),
                      textAlign: TextAlign.right,
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blueGrey,
                    border: Border.all(color: Colors.blueGrey, width: 3.0),
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 40.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.asset(
                              "images/sunrise.png",
                              width: 64.0,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "${timeBeforeSunrise.inHours.abs()}h ${timeBeforeSunrise.inMinutes % 60}min",
                                  style: kSunTitleTextStyle,
                                ),
                                Text(
                                  "${timeBeforeSunrise.isNegative ? "before" : "after"} sunrise",
                                  style: kSunBodyTextStyle,
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.asset(
                              "images/sunset.png",
                              width: 64.0,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "${timeBeforeSunset.inHours.abs()}h ${timeBeforeSunset.inMinutes % 60}min",
                                  style: kSunTitleTextStyle,
                                ),
                                Text(
                                  "${timeBeforeSunset.isNegative ? "before" : "after"} sunset",
                                  style: kSunBodyTextStyle,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
