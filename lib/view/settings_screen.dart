import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_select/smart_select.dart';
import 'package:tax_simplified/constants.dart';
import 'package:tax_simplified/helpers/toast.dart';
import 'package:tax_simplified/widgets/appbar.dart';
import 'package:tax_simplified/widgets/ni_preference_dropdown.dart';
import 'package:tax_simplified/widgets/rounded_button.dart';
import 'package:tax_simplified/widgets/rounded_container.dart';

class SettingsScreen extends StatefulWidget {
  SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isNIChecked = false;
  var pension_ctr = 0;
  bool niInfoProvided = false;
  var prefs = null;

  //controller for text input
  var pensionController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    retrieveSettings();
  }

  Future<void> retrieveSettings() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      if (prefs.getInt("pension_contribution") != null) {
        pension_ctr = prefs.getInt("pension_contribution")!;
      }

      if (prefs.getBool("ni_info_provided") != null) {
        niInfoProvided = prefs.getBool("ni_info_provided")!;
        if (prefs.getBool("ni_checked") != null) {
          isNIChecked = prefs.getBool("ni_checked")!;
        }
      }
      pensionController.text = pension_ctr != 0 ? "%${pension_ctr}" : "";
    });
  }

  Future<void> saveSettings(niEnabled, pension) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var pension_ctr = int.tryParse(pension);
    prefs.setBool("ni_checked", niEnabled);
    prefs.setInt("pension_contribution", pension_ctr != null ? pension_ctr : 0);
    showSuccessToast("Settings saved successfully!");
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: darkPurple,
      appBar: SystemAppBar(
        title: 'Settings',
        color: Colors.white,
        textColor: darkPurple,
      ),
      body: Column(
        children: [
          RoundedWidget(
            backgroundColor: Colors.white,
            widgetHeight: height * 0.5,
            childWidget: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(top: 26.0, left: 16.0, right: 16.0),
                  child: Text(
                    "National Insurance",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: darkPurple,
                      fontWeight: FontWeight.w600,
                      fontSize: 22.0,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 6.0, left: 16.0, right: 16.0),
                  child: Text(
                    "Before we can calculate NI you must tell us which of the following applies to you",
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
                NIPreferenceDropdown(
                  updateState: (dropdownVal) {
                    setState(() {
                      prefs.setBool("ni_info_provided", true);
                      retrieveSettings();
                    });
                  },
                  clearChoice: () {
                    setState(() {
                      prefs.setBool("ni_info_provided", false);
                      retrieveSettings();
                    });
                  },
                ),
                niInfoProvided
                    ? Padding(
                        padding: const EdgeInsets.only(
                            top: 26.0, left: 16.0, right: 16.0),
                        child: Text(
                          "Include National Insurance",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: niInfoProvided ? darkPurple : greyColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 22.0,
                          ),
                        ),
                      )
                    : Container(),
                niInfoProvided
                    ? Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: Row(
                          children: [
                            Transform.scale(
                              scale: 1.20,
                              child: Checkbox(
                                value: isNIChecked,
                                checkColor: Colors.white,
                                activeColor: darkPurple,
                                onChanged: (bool? value) {
                                  setState(() {
                                    isNIChecked = value!;
                                  });
                                },
                              ),
                            ),
                            Text(
                              isNIChecked ? 'Enabled' : 'Disabled',
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container(),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 22.0, left: 16.0, right: 16.0),
                  child: Text(
                    "Pension Contribution",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: darkPurple,
                      fontWeight: FontWeight.w600,
                      fontSize: 22.0,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 16.0, right: 16.0),
                  width: width * 0.45,
                  child: TextField(
                      style: TextStyle(
                        color: greyColor,
                        fontSize: 22.0,
                        fontWeight: FontWeight.w600,
                      ),
                      controller: pensionController,
                      cursorColor: darkPurple,
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: greyColor),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: greyColor),
                        ),
                      ),
                      inputFormatters: [
                        CurrencyTextInputFormatter(
                          symbol: "%",
                          decimalDigits: 0,
                        )
                      ],
                      keyboardType:
                          TextInputType.number // Only numbers can be entered
                      ),
                ),
                Spacer(),
                RoundedButtonWidget(
                  text: 'Update settings',
                  onPressed: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                    saveSettings(isNIChecked,
                        pensionController.text.replaceAll('%', ''));
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
