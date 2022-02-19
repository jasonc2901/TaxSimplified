import 'package:flutter/material.dart';
import 'package:tax_simplified/widgets/breakdown_salary_widget.dart';
import 'package:tax_simplified/widgets/percentage_breakdown.dart';

import '../constants.dart';

class BreakdownScreen extends StatefulWidget {
  final double grossSalary;
  final double netSalary;
  final double taxPercentage;

  BreakdownScreen(
      {Key? key,
      required this.grossSalary,
      required this.netSalary,
      required this.taxPercentage})
      : super(key: key);

  @override
  State<BreakdownScreen> createState() => _BreakdownScreenState();
}

class _BreakdownScreenState extends State<BreakdownScreen> {
  String removeDecimalZeroFormat(double n) {
    return n.toStringAsFixed(n.truncateToDouble() == n ? 0 : 1);
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: darkPurple,
        title: Text(
          "Salary Breakdown",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w400,
            fontSize: 32.0,
          ),
        ),
        shadowColor: Colors.transparent,
      ),
      body: Column(
        children: [
          Container(
            height: height * 0.45,
            width: width,
            decoration: BoxDecoration(
              color: darkPurple,
              borderRadius: new BorderRadius.only(
                bottomLeft: const Radius.circular(40.0),
                bottomRight: const Radius.circular(40.0),
              ),
            ),
            child: BreakdownSalaryWidget(
              grossSalary: widget.grossSalary,
              netSalary: widget.netSalary,
            ),
          ),
          SizedBox(
            height: height * 0.03,
          ),
          PercentageBreakdown(
            taxPercentage: widget.taxPercentage,
          )
        ],
      ),
    );
  }
}
