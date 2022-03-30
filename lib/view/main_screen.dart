import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:tax_simplified/constants.dart';
import 'package:tax_simplified/helpers/toast.dart';
import 'package:tax_simplified/view/breakdown_screen.dart';
import 'package:tax_simplified/view/settings_screen.dart';
import 'package:tax_simplified/widgets/rounded_button.dart';
import 'package:tax_simplified/widgets/rounded_container.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var salaryController = new TextEditingController();

  double netSalary = -1;
  double grossSalary = -1;
  double taxPercentage = 0;

  @override
  void initState() {
    resetValues();
    super.initState();
  }

  void calculateSalary(String salary) {
    FocusManager.instance.primaryFocus?.unfocus();
    // ignore: avoid_init_to_null
    var selectedCountry = salary.length > 0
        ? countryList.where((c) => c.isSelected == true).first
        : null;

    if (selectedCountry == null) {
      showErrorToast('Country and Salary must both be provided!');
      return;
    }

    int parsedGross = int.parse(salary.substring(1).replaceAll(',', ''));

    selectedCountry.brackets.forEach((bracket) {
      if (bracket.range.length > 1) {
        if (parsedGross >= bracket.range[0] &&
            parsedGross <= bracket.range[1]) {
          setState(() {
            netSalary =
                parsedGross - (parsedGross * bracket.percentage).toDouble();
            grossSalary = parsedGross.toDouble();
            taxPercentage = bracket.percentage;
          });
        }
      } else {
        if (parsedGross >= bracket.range[0]) {
          setState(() {
            netSalary =
                parsedGross - (parsedGross * bracket.percentage).toDouble();
            grossSalary = parsedGross.toDouble();
            taxPercentage = bracket.percentage;
          });
        }
      }
    });
  }

  void resetValues() {
    setState(() {
      countryList.forEach((c) => c.isSelected = false);
      breakdownMethods.forEach((m) => m.isSelected = m.method == 'Yearly');
      breakdownPercentages.forEach((p) => p.isSelected = false);
      salaryController.clear();
      netSalary = -1;
      grossSalary = -1;
      taxPercentage = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    void showBreakdown() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BreakdownScreen(
            netSalary: netSalary,
            grossSalary: grossSalary,
            taxPercentage: taxPercentage,
          ),
        ),
      ).then(
        (value) => setState(
          (() => {resetValues()}),
        ),
      );
    }

    void showSettings() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SettingsScreen()),
      ).then(
        (value) => setState(
          (() => {resetValues()}),
        ),
      );
    }

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: darkPurple,
        body: Column(
          children: [
            RoundedWidget(
              backgroundColor: Colors.white,
              widgetHeight: height * 0.65,
              childWidget: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: height * 0.05,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Spacer(),
                      IconButton(
                        icon: const Icon(Icons.settings),
                        color: darkPurple,
                        iconSize: 35,
                        onPressed: () {
                          setState(() {
                            showSettings();
                          });
                        },
                      ),
                    ],
                  ),
                  Center(
                    child: Text(
                      "Salary Information",
                      style: TextStyle(
                        color: darkPurple,
                        fontWeight: FontWeight.w400,
                        fontSize: 32.0,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      "Country",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: darkPurple,
                        fontWeight: FontWeight.w400,
                        fontSize: 28.0,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ...countryList
                          .map(
                            (country) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: new InkWell(
                                onTap: () {
                                  setState(() {
                                    //set all previous countries to not selected
                                    countryList
                                        .forEach((c) => c.isSelected = false);
                                    //set the current country to selected
                                    country.isSelected = true;
                                  });
                                },
                                child: Column(
                                  children: [
                                    Container(
                                      width: 80.0,
                                      height: 80.0,
                                      decoration: BoxDecoration(
                                        color: const Color(0xff7c94b6),
                                        image: DecorationImage(
                                          image: AssetImage(country.imgUrl),
                                          fit: BoxFit.cover,
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(50.0)),
                                        border: country.isSelected
                                            ? Border.all(
                                                color: darkPurple,
                                                width: 4.0,
                                              )
                                            : null,
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(5.0),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(25.0),
                                        ),
                                        color: country.isSelected
                                            ? darkPurple
                                            : Colors.white,
                                      ),
                                      child: Text(
                                        "${country.name}",
                                        style: TextStyle(
                                          color: country.isSelected
                                              ? Colors.white
                                              : greyColor,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                          .toList()
                    ],
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 16.0, left: 16.0, right: 16.0),
                    child: Text(
                      "Salary per year (GBP)",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: darkPurple,
                        fontWeight: FontWeight.w400,
                        fontSize: 28.0,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                    child: Container(
                      width: width * 0.45,
                      child: new TextField(
                          style: TextStyle(
                            color: greyColor,
                            fontSize: 32.0,
                            fontWeight: FontWeight.w600,
                          ),
                          controller: salaryController,
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
                              symbol: "£",
                              decimalDigits: 0,
                              locale: "en",
                            )
                          ],
                          keyboardType: TextInputType
                              .number // Only numbers can be entered
                          ),
                    ),
                  ),
                  Spacer(),
                  RoundedButtonWidget(
                    onPressed: () => calculateSalary(salaryController.text),
                    text: 'Caculate',
                    color: orangeColor,
                    padding: height * 0.05,
                  )
                ],
              ),
            ),
            SizedBox(
              height: height * 0.03,
            ),
            netSalary > -1
                ? Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Your yearly salary after tax is',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 26.0,
                          ),
                        ),
                        Text(
                          '${formatCurrency.format(netSalary)}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 46.0,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        RoundedButtonWidget(
                          onPressed: () => showBreakdown(),
                          text: 'Full Breakdown',
                          color: orangeColor,
                          padding: 0,
                        )
                      ],
                    ),
                  )
                : Container(),
            Spacer()
          ],
        ),
      ),
    );
  }
}
