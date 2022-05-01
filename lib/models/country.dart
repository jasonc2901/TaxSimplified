import 'package:tax_simplified/models/tax_bracket.dart';

class Country {
  String name;
  String imgUrl;
  bool isSelected;
  int personalAllowance;
  double nationalInsurancePercentage;
  double nationalInsuranceHigherPercentage;
  int nationalInsuranceUpperLimit;
  List<TaxBracket> brackets;

  Country(
      {required this.name,
      required this.imgUrl,
      required this.isSelected,
      required this.personalAllowance,
      required this.nationalInsurancePercentage,
      required this.nationalInsuranceHigherPercentage,
      required this.nationalInsuranceUpperLimit,
      required this.brackets});
}
