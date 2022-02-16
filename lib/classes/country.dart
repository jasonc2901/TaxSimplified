import 'package:tax_simplified/classes/tax_bracket.dart';

class Country {
  String name;
  String imgUrl;
  bool isSelected;
  List<TaxBracket> brackets;

  Country(
      {required this.name,
      required this.imgUrl,
      required this.isSelected,
      required this.brackets});
}
