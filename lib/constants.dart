import 'package:flutter/painting.dart';

const Color lightPurple = Color(0xFF6651D9);
const Color darkPurple = Color(0xFF5241C5);
const Color orangeColor = Color(0xFFFF7518);
const String apptitle = "Tax Simplified";

class Country {
  String name;
  String imgUrl;

  Country({required this.name, required this.imgUrl});
}

List<Country> countryList = [
  new Country(name: 'England', imgUrl: 'assets/england.png'),
  new Country(name: 'Scotland', imgUrl: 'assets/scotland.png'),
  new Country(name: 'N. Ireland', imgUrl: 'assets/NI.png'),
  new Country(name: 'Wales', imgUrl: 'assets/wales.png'),
];
