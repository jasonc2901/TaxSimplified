import 'package:shared_preferences/shared_preferences.dart';
import 'package:tax_simplified/helpers/toast.dart';

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
