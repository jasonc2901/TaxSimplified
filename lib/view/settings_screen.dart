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

import '../helpers/setting_control.dart';

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
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      retrieveSettings();
    });
  }

  var loading = true;
  var dropdownVal = "";
  Future<void> retrieveSettings() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      if (prefs.getInt("pension_contribution") != null) {
        pension_ctr = prefs.getInt("pension_contribution")!;
      } else {
        pension_ctr = 0;
      }

      if (prefs.getBool("ni_info_provided") != null) {
        niInfoProvided = prefs.getBool("ni_info_provided")!;
        if (prefs.getBool("ni_checked") != null) {
          isNIChecked = prefs.getBool("ni_checked")!;
        } else {
          isNIChecked = false;
        }
      } else {
        niInfoProvided = false;
      }

      dropdownVal = prefs.getString("ni_dropdown_selection") ?? "";
      pensionController.text = pension_ctr != 0 ? "%${pension_ctr}" : "";
      loading = false;
    });
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
            widgetHeight: height * 0.6,
            childWidget: loading
                ? Center(
                    child: Container(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(),
                    ),
                  )
                : Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 26.0, left: 16.0, right: 16.0),
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
                          padding: const EdgeInsets.only(
                              top: 6.0, left: 16.0, right: 16.0),
                          child: Text(
                            "Before we can calculate NI you must tell us which of the following applies to you",
                            style: TextStyle(fontSize: 16.0),
                          ),
                        ),
                        NIPreferenceDropdown(
                          updateState: (dropdownVal) {
                            updateNIDropdownSettings(dropdownVal, true);
                            retrieveSettings();
                          },
                          clearChoice: () {
                            setState(() {
                              updateNIDropdownSettings("", false);
                              retrieveSettings();
                            });
                          },
                          value: dropdownVal,
                        ),
                        niInfoProvided
                            ? Padding(
                                padding: const EdgeInsets.only(
                                    top: 26.0, left: 16.0, right: 16.0),
                                child: Text(
                                  "Include National Insurance",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color:
                                        niInfoProvided ? darkPurple : greyColor,
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
                          padding: const EdgeInsets.only(
                              top: 22.0, left: 16.0, right: 16.0),
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
                              keyboardType: TextInputType
                                  .number // Only numbers can be entered
                              ),
                        ),
                        Spacer(),
                        RoundedButtonWidget(
                          text: 'Update settings',
                          color: orangeColor,
                          padding: height * 0.02,
                          onPressed: () {
                            FocusManager.instance.primaryFocus?.unfocus();
                            saveSettings(isNIChecked,
                                pensionController.text.replaceAll('%', ''));
                          },
                        ),
                        RoundedButtonWidget(
                          text: 'Reset settings',
                          color: redColor,
                          padding: height * 0.02,
                          onPressed: () async {
                            FocusManager.instance.primaryFocus?.unfocus();
                            await resetAllSettings().then((value) async {
                              loading = true;
                              await retrieveSettings().then((value) {
                                showSuccessToast(
                                    "Settings reset successfully!");
                              });
                            });
                          },
                        )
                      ],
                    ),
                  ),
          )
        ],
      ),
    );
  }
}
