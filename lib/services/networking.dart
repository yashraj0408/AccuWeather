import 'dart:convert';

import 'package:clima/utilities/constants.dart';
import 'package:http/http.dart' as http;

class NetworkHelper {
  final String url;

  NetworkHelper(this.url);

  Future<dynamic> getData() async {
    http.Response res = await http.get("$url&units=metric&appid=$kOwmApiKey");

    if (res.statusCode == 200) {
      return jsonDecode(res.body);
    } else {
      print("${res.statusCode}: No weather data found");
    }
  }
}
