import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:tax_simplified/constants.dart';
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
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var pensionController = new TextEditingController();

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
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                  child: Row(
                    children: [
                      Text(
                        isNIChecked ? 'Enabled' : 'Disabled',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
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
