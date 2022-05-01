import 'package:shared_preferences/shared_preferences.dart';
import 'package:tax_simplified/helpers/toast.dart';
import 'package:tax_simplified/models/tax_model.dart';

//#region General Settings
Future<void> saveSettings(niEnabled, pension) async {
  var prefs = await SharedPreferences.getInstance();
  var pension_ctr = int.tryParse(pension);
  prefs.setBool("ni_checked", niEnabled);
  prefs.setInt("pension_contribution", pension_ctr != null ? pension_ctr : 0);
  showSuccessToast("Settings saved successfully!");
}

Future<void> updateNIDropdownSettings(val, isEnabled) async {
  var prefs = await SharedPreferences.getInstance();
  prefs.setString("ni_dropdown_selection", val);
  prefs.setBool("ni_info_provided", isEnabled);
}

Future<void> resetAllSettings() async {
  var prefs = await SharedPreferences.getInstance();
  prefs.clear();
}

Future<bool> isPensionProvided() async {
  var prefs = await SharedPreferences.getInstance();

  return prefs.getInt("pension_contribution") != null &&
      prefs.getInt("pension_contribution")! > 0;
}
//#endregion

//#region Pension
Future<int> getPensionContribution() async {
  var prefs = await SharedPreferences.getInstance();

  return prefs.getInt("pension_contribution") != null
      ? prefs.getInt("pension_contribution")! > 0
          ? prefs.getInt("pension_contribution")!
          : 0
      : 0;
}

double getMonthlyPensionReduction(double net, int contribution) {
  var monthly = net / 12;
  return (monthly / 100) * contribution;
}

double getYearlyPensionReduction(double net, int contribution) {
  var monthly = net / 12;
  return ((monthly / 100) * contribution) * 12;
}

double applyPensionReduction(double net, int contribution) {
  var yearlyLoss = getYearlyPensionReduction(net, contribution);
  return net - yearlyLoss;
}
//#endregion

//#region National Insurance
Future<bool> isNationalInsuranceEnabled() async {
  var prefs = await SharedPreferences.getInstance();

  var infoProvided = prefs.getBool("ni_info_provided") != null
      ? prefs.getBool("ni_info_provided")!
      : false;

  var isEnabled = prefs.getBool("ni_checked") != null
      ? prefs.getBool("ni_checked")!
      : false;

  return (infoProvided && isEnabled) ? true : false;
}

Future<String> getNIDropdownVal() async {
  var prefs = await SharedPreferences.getInstance();
  return prefs.getString("ni_dropdown_selection")!;
}

double applyNIReduction(TaxModel model) {
  if (model.gross > model.selectedCountry.personalAllowance &&
      model.gross <= model.selectedCountry.nationalInsuranceUpperLimit) {
    //if within the range apply standard NI rate to taxable income
    var taxable = model.userSalary - model.selectedCountry.personalAllowance;
    var niToPay = taxable * model.selectedCountry.nationalInsurancePercentage;
    return model.net - niToPay.ceil();
  } else if (model.gross > model.selectedCountry.nationalInsuranceUpperLimit) {
    var taxable = model.selectedCountry.nationalInsuranceUpperLimit -
        model.selectedCountry.personalAllowance;
    var standardNiToPay =
        taxable * model.selectedCountry.nationalInsurancePercentage;
    var aboveLimit =
        model.userSalary - model.selectedCountry.nationalInsuranceUpperLimit;
    var additionalNiToPay =
        (aboveLimit * model.selectedCountry.nationalInsuranceHigherPercentage)
            .ceil();
    var totalNi = standardNiToPay + additionalNiToPay;

    return model.net - totalNi;
  } else {
    return model.net;
  }
}
//#endregion
