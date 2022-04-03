import 'package:shared_preferences/shared_preferences.dart';
import 'package:tax_simplified/constants.dart';
import 'package:tax_simplified/helpers/toast.dart';

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

double applyNIReduction(double net, double gross, String taxLetter) {
  //using the letter get the percentage associated to selection
  return net;
}
//#endregion
