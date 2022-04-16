import 'country.dart';

class TaxModel {
  Country selectedCountry;
  double net;
  double gross;
  double tax;
  int userSalary;

  TaxModel(
      {required this.selectedCountry,
      required this.net,
      required this.gross,
      required this.tax,
      required this.userSalary});
}
