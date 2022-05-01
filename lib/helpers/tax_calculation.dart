import 'package:tax_simplified/models/tax_model.dart';

void calculateTax(TaxModel model) {
  model.selectedCountry.brackets.forEach((bracket) {
    if (bracket.range.length > 1) {
      if (model.userSalary >= bracket.range[0] &&
          model.userSalary <= bracket.range[1]) {
        if (model.userSalary > model.selectedCountry.personalAllowance) {
          var taxable =
              model.userSalary - model.selectedCountry.personalAllowance;
          var taxToPay = taxable * bracket.percentage;
          model.net = model.userSalary - taxToPay;
        } else {
          model.net = model.userSalary.toDouble();
        }
        model.gross = model.userSalary.toDouble();
        model.tax = bracket.percentage;
      }
    } else {
      if (model.userSalary >= bracket.range[0]) {
        //get the taxable
        var allowance = model.selectedCountry.personalAllowance;
        if (model.userSalary > 100000) {
          allowance = 0;
        }
        var taxable = model.userSalary - allowance;
        var taxToPay = taxable * bracket.percentage;
        model.net = model.userSalary - taxToPay;
        model.gross = model.userSalary.toDouble();
        model.tax = bracket.percentage;
      }
    }
  });
}
