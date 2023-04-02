import 'package:flutter/material.dart';

const kOwmUrl = "https://api.openweathermap.org/data/2.5/weather";
const kOwmApiKey = "27d09b7691f9913703cc7108ae74a930";

const kConditionTextStyle = TextStyle(
  fontSize: 80.0,
);

const kTempValueTextStyle = TextStyle(
  fontFamily: 'Spartan',
  fontWeight: FontWeight.w900,
  fontSize: 80.0,
);

const kTempUnitBoxDecoration = BoxDecoration(
  border: Border(
    bottom: BorderSide(
      width: 5.0,
      color: Colors.white,
    ),
  ),
);

const kTempUnitTextStyle = TextStyle(
  fontFamily: 'Spartan',
  fontWeight: FontWeight.w900,
  fontSize: 40.0,
  height: 1.0,
);

const kTempSubTextStyle = TextStyle(
  fontFamily: 'Spartan',
  fontSize: 24.0,
  letterSpacing: 10.0,
);

const kMessageTextStyle = TextStyle(
  fontFamily: 'Spartan',
  fontWeight: FontWeight.w900,
  fontSize: 50.0,
);

const kDescriptionTextStyle = TextStyle(
  fontFamily: 'Spartan',
  fontSize: 30.0,
);

const kButtonTextStyle = TextStyle(
  fontSize: 30.0,
  fontFamily: 'Spartan',
  fontWeight: FontWeight.w900,
);

const kSunTitleTextStyle = TextStyle(
    fontSize: 24.0,
    fontFamily: 'Spartan',
    fontWeight: FontWeight.w900,
    letterSpacing: 2.0);

const kSunBodyTextStyle = TextStyle(
  fontFamily: 'Spartan',
  fontSize: 16.0,
);

const kTextFieldInputDecoration = InputDecoration(
  filled: true,
  fillColor: Colors.white,
  icon: Icon(
    Icons.location_city,
    color: Colors.white,
  ),
  hintText: "Enter city name",
  hintStyle: TextStyle(color: Colors.grey),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
    borderSide: BorderSide.none,
  ),
);
