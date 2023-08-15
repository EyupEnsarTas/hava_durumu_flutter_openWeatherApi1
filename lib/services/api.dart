
//import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;



const apiKey = '4a1a3d9495c66dc1d63f6d9b36b8cc28'; // OpenWeatherMap API anahtarınızı buraya ekleyin

Future<Map<String, dynamic>> getWeatherData(String city) async {
  final response = await http.get(Uri.parse(
      'http://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric'));

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Failed to load weather data');
  }
}