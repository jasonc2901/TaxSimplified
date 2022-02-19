import 'package:flutter/material.dart';
import 'package:tax_simplified/constants.dart';

class BreakdownSalaryWidget extends StatefulWidget {
  final double grossSalary;
  final double netSalary;
  BreakdownSalaryWidget(
      {Key? key, required this.grossSalary, required this.netSalary})
      : super(key: key);

  @override
  State<BreakdownSalaryWidget> createState() => _BreakdownSalaryWidgetState();
}

class _BreakdownSalaryWidgetState extends State<BreakdownSalaryWidget> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: height * 0.02,
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ...breakdownMethods.map(
                (method) => ElevatedButton(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      method.method,
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                  onPressed: () => {
                    setState(() {
                      breakdownMethods.forEach((m) => m.isSelected = false);
                      method.isSelected = true;
                    })
                  },
                  style: ButtonStyle(
                    backgroundColor: method.isSelected
                        ? MaterialStateProperty.all<Color>(orangeColor)
                        : MaterialStateProperty.all<Color>(greyColor),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    shadowColor:
                        MaterialStateProperty.all<Color>(Colors.transparent),
                    overlayColor:
                        MaterialStateProperty.all<Color>(Colors.transparent),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
          child: Text(
            "Gross Salary",
            textAlign: TextAlign.left,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w400,
              fontSize: 22.0,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 16.0, left: 16.0, right: 16.0),
          child: Text(
            '${formatCurrency.format(widget.grossSalary)}',
            textAlign: TextAlign.left,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w400,
              fontSize: 42.0,
            ),
          ),
        ),
        SizedBox(
          height: height * 0.02,
        ),
        Divider(
          color: Colors.white,
          indent: width * 0.05,
          endIndent: width * 0.05,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
          child: Text(
            "NET Salary",
            textAlign: TextAlign.left,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w400,
              fontSize: 22.0,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 16.0, left: 16.0, right: 16.0),
          child: Text(
            '${formatCurrency.format(widget.netSalary)}',
            textAlign: TextAlign.left,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w400,
              fontSize: 42.0,
            ),
          ),
        ),
      ],
    );
  }
}
