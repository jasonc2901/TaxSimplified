import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tax_simplified/constants.dart';
import 'package:tax_simplified/view/breakdown_screen.dart';

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

  void calculateSalary(String salary) {
    //close the keyboard when calculate is pressed
    FocusManager.instance.primaryFocus?.unfocus();

    int parsedGross = int.parse(salary.substring(1).replaceAll(',', ''));
    var selectedCountry = countryList.where((c) => c.isSelected == true).first;
    selectedCountry.brackets.forEach((bracket) {
      if (bracket.range.length > 1) {
        if (parsedGross >= bracket.range[0] &&
            parsedGross <= bracket.range[1]) {
          setState(() {
            netSalary = parsedGross - (parsedGross * bracket.percentage);
            grossSalary = parsedGross.toDouble();
            taxPercentage = bracket.percentage;
          });
        }
      } else {
        if (parsedGross >= bracket.range[0]) {
          setState(() {
            netSalary = parsedGross - (parsedGross * bracket.percentage);
            grossSalary = parsedGross.toDouble();
            taxPercentage = bracket.percentage;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: darkPurple,
        body: Column(
          children: [
            Container(
              height: height * 0.6,
              width: width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: new BorderRadius.only(
                  bottomLeft: const Radius.circular(40.0),
                  bottomRight: const Radius.circular(40.0),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: height * 0.06),
                    child: Center(
                      child: Text(
                        "Salary Information",
                        style: TextStyle(
                          color: lightPurple,
                          fontWeight: FontWeight.w400,
                          fontSize: 32.0,
                        ),
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
                        color: lightPurple,
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
                        color: lightPurple,
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
                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(bottom: height * 0.05),
                      child: ElevatedButton(
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            'Calculate',
                            style: TextStyle(
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                        onPressed: () => {
                          calculateSalary(salaryController.text),
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(orangeColor),
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          shadowColor: MaterialStateProperty.all<Color>(
                              Colors.transparent),
                          overlayColor: MaterialStateProperty.all<Color>(
                              Colors.transparent),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              side: BorderSide(color: orangeColor),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
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
                        Center(
                          child: Padding(
                            padding: EdgeInsets.only(
                                bottom: height * 0.05, top: height * 0.05),
                            child: ElevatedButton(
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Text(
                                  'Full Breakdown',
                                  style: TextStyle(
                                    fontSize: 18.0,
                                  ),
                                ),
                              ),
                              onPressed: () => {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => BreakdownScreen(
                                            netSalary: netSalary,
                                            grossSalary: grossSalary,
                                            taxPercentage: taxPercentage,
                                          )),
                                )
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        orangeColor),
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.white),
                                shadowColor: MaterialStateProperty.all<Color>(
                                    Colors.transparent),
                                overlayColor: MaterialStateProperty.all<Color>(
                                    Colors.transparent),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                    side: BorderSide(color: orangeColor),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
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
