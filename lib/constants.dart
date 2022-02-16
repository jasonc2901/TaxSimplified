import 'package:flutter/painting.dart';
import 'package:tax_simplified/classes/tax_bracket.dart';
import 'classes/country.dart';

const Color lightPurple = Color(0xFF6651D9);
const Color darkPurple = Color(0xFF5241C5);
const Color orangeColor = Color(0xFFFF7518);
const Color greyColor = Color(0xFF6D6A6A);
const String apptitle = "Tax Simplified";

List<Country> countryList = [
  new Country(
    name: 'England',
    imgUrl: 'assets/england.png',
    isSelected: false,
    brackets: [
      new TaxBracket(range: [0, 12569], percentage: 0),
      new TaxBracket(range: [12570, 37700], percentage: 0.20),
      new TaxBracket(range: [37701, 150000], percentage: 0.40),
      new TaxBracket(range: [150001], percentage: 0.50),
    ],
  ),
  new Country(
    name: 'Scotland',
    imgUrl: 'assets/scotland.png',
    isSelected: false,
    brackets: [
      new TaxBracket(range: [0, 2097], percentage: 0.19),
      new TaxBracket(range: [2098, 12726], percentage: 0.20),
      new TaxBracket(range: [12727, 31092], percentage: 0.21),
      new TaxBracket(range: [31093, 150000], percentage: 0.40),
      new TaxBracket(range: [150001], percentage: 0.46),
    ],
  ),
  new Country(
    name: 'N. Ireland',
    imgUrl: 'assets/NI.png',
    isSelected: false,
    brackets: [
      new TaxBracket(range: [0, 12569], percentage: 0),
      new TaxBracket(range: [12570, 37700], percentage: 0.20),
      new TaxBracket(range: [37701, 150000], percentage: 0.40),
      new TaxBracket(range: [150001], percentage: 0.50),
    ],
  ),
  new Country(
    name: 'Wales',
    imgUrl: 'assets/wales.png',
    isSelected: false,
    brackets: [
      new TaxBracket(range: [0, 12569], percentage: 0),
      new TaxBracket(range: [12570, 37701], percentage: 0.20),
      new TaxBracket(range: [37701, 150000], percentage: 0.40),
      new TaxBracket(range: [150001], percentage: 0.45),
    ],
  )
];
