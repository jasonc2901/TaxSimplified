import 'package:flutter/painting.dart';
import 'package:intl/intl.dart';
import 'package:smart_select/smart_select.dart';
import 'package:tax_simplified/models/breakdown_methods.dart';
import 'package:tax_simplified/models/breakdown_percentage.dart';
import 'package:tax_simplified/models/tax_bracket.dart';
import 'package:tax_simplified/models/country.dart';

//all reused colours within the app
//#region colours
const Color lightPurple = Color(0xFF6651D9);
const Color darkPurple = Color(0xFF5241C5);
const Color orangeColor = Color(0xFFFF7518);
const Color redColor = Color.fromARGB(255, 240, 76, 35);
const Color greyColor = Color(0xFF6D6A6A);
const String apptitle = "Tax Simplified";
//#endregion

int latestUKTaxThreshold = 12570;
int nationalInsuranceUpperLimit = 50270;
double latesUKNationalInsurance = 0.1325;
double higherUKNationalInsurance = 0.0325;
//list of available countries and associated tax brackets
List<Country> countryList = [
  new Country(
    name: 'England',
    imgUrl: 'assets/england.png',
    isSelected: false,
    personalAllowance: latestUKTaxThreshold,
    nationalInsurancePercentage: latesUKNationalInsurance,
    nationalInsuranceUpperLimit: nationalInsuranceUpperLimit,
    nationalInsuranceHigherPercentage: higherUKNationalInsurance,
    brackets: [
      new TaxBracket(range: [0, 12570], percentage: 0),
      new TaxBracket(range: [12571, 37700], percentage: 0.20),
      new TaxBracket(range: [37701, 150000], percentage: 0.40),
      new TaxBracket(range: [150001], percentage: 0.45),
    ],
  ),
  new Country(
    name: 'Scotland',
    imgUrl: 'assets/scotland.png',
    isSelected: false,
    personalAllowance: latestUKTaxThreshold,
    nationalInsurancePercentage: latesUKNationalInsurance,
    nationalInsuranceUpperLimit: nationalInsuranceUpperLimit,
    nationalInsuranceHigherPercentage: higherUKNationalInsurance,
    brackets: [
      new TaxBracket(range: [0, 2163], percentage: 0.19),
      new TaxBracket(range: [2164, 13118], percentage: 0.20),
      new TaxBracket(range: [13119, 31092], percentage: 0.21),
      new TaxBracket(range: [31093, 150000], percentage: 0.41),
      new TaxBracket(range: [150001], percentage: 0.46),
    ],
  ),
  new Country(
    name: 'N. Ireland',
    imgUrl: 'assets/NI.png',
    isSelected: false,
    personalAllowance: latestUKTaxThreshold,
    nationalInsurancePercentage: latesUKNationalInsurance,
    nationalInsuranceUpperLimit: nationalInsuranceUpperLimit,
    nationalInsuranceHigherPercentage: higherUKNationalInsurance,
    brackets: [
      new TaxBracket(range: [0, 12570], percentage: 0),
      new TaxBracket(range: [12571, 37700], percentage: 0.20),
      new TaxBracket(range: [37701, 150000], percentage: 0.40),
      new TaxBracket(range: [150001], percentage: 0.45),
    ],
  ),
  new Country(
    name: 'Wales',
    imgUrl: 'assets/wales.png',
    isSelected: false,
    personalAllowance: latestUKTaxThreshold,
    nationalInsurancePercentage: latesUKNationalInsurance,
    nationalInsuranceHigherPercentage: higherUKNationalInsurance,
    nationalInsuranceUpperLimit: nationalInsuranceUpperLimit,
    brackets: [
      new TaxBracket(range: [0, 12570], percentage: 0),
      new TaxBracket(range: [12571, 37700], percentage: 0.20),
      new TaxBracket(range: [37701, 150000], percentage: 0.40),
      new TaxBracket(range: [150001], percentage: 0.45),
    ],
  )
];

int thresholdLimit = 100000;
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
  new BreakdownPercentage(method: "Pension", isSelected: false),
  new BreakdownPercentage(method: "NI", isSelected: false)
];

//list of available options for the settings dropdown
List<S2Choice<String>> ni_dropdown_options = [
  S2Choice<String>(value: 'B', title: 'I am a married woman/Widowed woman'),
  S2Choice<String>(value: 'C', title: 'I am over the state pension age'),
  S2Choice<String>(value: 'H', title: 'I am an apprentice under 25'),
  S2Choice<String>(value: 'M', title: 'I am an apprentice under 21'),
  S2Choice<String>(value: 'A', title: 'None of the above'),
];
//reusable currency formatter
final formatCurrency =
    new NumberFormat.simpleCurrency(locale: 'en_GB', decimalDigits: 2);
