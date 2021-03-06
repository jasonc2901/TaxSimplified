import 'package:flutter/material.dart';
import 'package:tax_simplified/models/country.dart';
import 'package:tax_simplified/widgets/breakdown_salary_widget.dart';
import 'package:tax_simplified/widgets/percentage_breakdown.dart';
import 'package:tax_simplified/widgets/rounded_container.dart';

import '../constants.dart';
import '../widgets/appbar.dart';

class BreakdownScreen extends StatefulWidget {
  final double grossSalary;
  final double netSalary;
  final double taxPercentage;
  final double pensionPercentage;
  final double nationalInsurancePercentage;
  final Country selectedCountry;

  BreakdownScreen(
      {Key? key,
      required this.grossSalary,
      required this.netSalary,
      required this.taxPercentage,
      required this.pensionPercentage,
      required this.selectedCountry,
      required this.nationalInsurancePercentage})
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

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: SystemAppBar(
        title: 'Salary Breakdown',
        color: darkPurple,
        textColor: Colors.white,
      ),
      body: Column(
        children: [
          RoundedWidget(
            backgroundColor: darkPurple,
            widgetHeight: height * 0.45,
            childWidget: BreakdownSalaryWidget(
              grossSalary: widget.grossSalary,
              netSalary: widget.netSalary,
            ),
          ),
          SizedBox(
            height: height * 0.03,
          ),
          PercentageBreakdown(
            taxPercentage: widget.taxPercentage,
            pensionPercentage: widget.pensionPercentage,
            niPercentage: widget.nationalInsurancePercentage,
          )
        ],
      ),
    );
  }
}
