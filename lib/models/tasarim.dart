import 'package:flutter/material.dart';



  final Color birincilRenk =    Color.fromARGB(255, 129, 223, 53);
  final Color ikincilRenk =    Color.fromARGB(255, 255, 255, 255);
  final Color UcunculRenk =  Color.fromARGB(255, 40, 216, 216);


  

  Widget getWeatherIcon(String iconCode) {
  switch (iconCode) {
    case '01d':
      return Image.asset('assets/clear.png');
    case '01n':
      return Image.asset('assets/celar.png');
    case '02d':
    case '02n':
      return Image.asset('assets/lightcloud.png');
    case '03d':
    case '03n':
      return Image.asset('assets/heavycloud.png');
    case '04d':
    case '04n':
      return Image.asset('assets/heavycloud.png');
    case '09d':
    case '09n':
      return Image.asset('assets/showers.png');
    case '10d':
    case '10n':
      return  Image.asset('assets/lightrain.png');
    case '11d':
    case '11n':
      return Image.asset('assets/thunderstrom.png');
    case '13d':
    case '13n':
      return Image.asset('assets/hail.png');;
    case '50d':
    case '50n':
      return Image.asset('assets/snow.png');
    default:
      return  Image.asset('assets/unchecked.png');;
  }
}
