import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:tax_simplified/constants.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
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
                                  print("${country.name} selected!");
                                },
                                child: Column(
                                  children: [
                                    Container(
                                      height: 80.0,
                                      width: 80.0,
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(50.0),
                                        child: Image.asset(
                                          country.imgUrl,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                    Text("${country.name}")
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
                    padding: const EdgeInsets.all(16.0),
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
                            color: darkPurple,
                            fontSize: 22.0,
                          ),
                          cursorColor: darkPurple,
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: lightPurple),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: darkPurple),
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
                          //calculate the current salary after tax
                          print("calculating salary ...")
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
            )
          ],
        ),
      ),
    );
  }
}
