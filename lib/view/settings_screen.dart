import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tax_simplified/constants.dart';
import 'package:tax_simplified/helpers/toast.dart';
import 'package:tax_simplified/widgets/appbar.dart';
import 'package:tax_simplified/widgets/rounded_button.dart';
import 'package:tax_simplified/widgets/rounded_container.dart';

class SettingsScreen extends StatefulWidget {
  SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isNIChecked = false;
  var pensionController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    retrieveSettings();
  }

  Future<void> retrieveSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      var pension_ctr = prefs.getInt("pension_contribution");
      isNIChecked = prefs.getBool("ni_checked")!;
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
            widgetHeight: height * 0.4,
            childWidget: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(top: 26.0, left: 16.0, right: 16.0),
                  child: Text(
                    "Include National Insurance",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: darkPurple,
                      fontWeight: FontWeight.w600,
                      fontSize: 22.0,
                    ),
                  ),
                ),
                Padding(
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
                ),
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
                    print(
                        'Settings\nNI Enabled: $isNIChecked\nPension: ${pensionController.text}');
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
