import 'package:flutter/painting.dart';
import 'package:intl/intl.dart';
import 'package:tax_simplified/models/breakdown_methods.dart';
import 'package:tax_simplified/models/breakdown_percentage.dart';
import 'package:tax_simplified/models/tax_bracket.dart';
import 'package:tax_simplified/models/country.dart';

//all reused colours within the app
const Color lightPurple = Color(0xFF6651D9);
const Color darkPurple = Color(0xFF5241C5);
const Color orangeColor = Color(0xFFFF7518);
const Color greyColor = Color(0xFF6D6A6A);
const String apptitle = "Tax Simplified";

//list of available countries and associated tax brackets
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

//list of the methods that can be selected on the breakdown view
//Yearly selected by default
List<BreakdownMethod> breakdownMethods = [
  new BreakdownMethod(method: "Yearly", isSelected: true),
  new BreakdownMethod(method: "Monthly", isSelected: false),
  new BreakdownMethod(method: "Weekly", isSelected: false),
];

//List of the salary breakdown percentage methods
//None selected by default
List<BreakdownPercentage> breakdownPercentages = [
  new BreakdownPercentage(method: "Tax", isSelected: false),
  new BreakdownPercentage(method: "NI Contr...", isSelected: false),
  new BreakdownPercentage(method: "Pension", isSelected: false)
];
//reusable currency formatter
final formatCurrency =
    new NumberFormat.simpleCurrency(locale: 'en_GB', decimalDigits: 0);
