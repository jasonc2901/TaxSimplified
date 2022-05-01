import 'package:flutter/material.dart';
import 'package:tax_simplified/constants.dart';
import 'package:tax_simplified/models/breakdown_percentage.dart';
import 'package:tax_simplified/widgets/percentage_button.dart';
import 'package:tax_simplified/widgets/percentage_explanation.dart';

class PercentageBreakdown extends StatefulWidget {
  final double taxPercentage;
  final double pensionPercentage;
  final double niPercentage;
  PercentageBreakdown({
    Key? key,
    required this.taxPercentage,
    required this.pensionPercentage,
    required this.niPercentage,
  }) : super(key: key);

  @override
  State<PercentageBreakdown> createState() => _PercentageBreakdownState();
}

class _PercentageBreakdownState extends State<PercentageBreakdown> {
  String removeDecimalZeroFormat(double n) {
    return n.toStringAsFixed(n.truncateToDouble() == n ? 0 : 1);
  }

  void updateSelected(BreakdownPercentage option) {
    setState(() {
      breakdownPercentages.forEach(
        (perc) {
          perc.isSelected = false;
        },
      );
      option.isSelected = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    var method = breakdownPercentages.any((p) => p.isSelected == true)
        ? breakdownPercentages.where((p) => p.isSelected == true).first.method
        : null;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ...breakdownPercentages.map(
                (p) => PercentageButton(
                  percentage:
                      '${p.method == "NI" ? widget.niPercentage * 100 : removeDecimalZeroFormat(p.method == "Pension" ? widget.pensionPercentage : widget.taxPercentage * 100)}%',
                  type: p.method,
                  isSelected: p.isSelected,
                  onPress: () {
                    updateSelected(p);
                  },
                ),
              )
            ],
          ),
          method != null
              ? Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.02),
                  child: PercentageExplanationWidget(
                    type: method,
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
