import 'package:flutter/material.dart';
import 'package:tax_simplified/constants.dart';
import 'package:tax_simplified/widgets/percentage_button.dart';

class PercentageBreakdown extends StatefulWidget {
  final double taxPercentage;
  final double pensionPercentage;
  PercentageBreakdown(
      {Key? key, required this.taxPercentage, required this.pensionPercentage})
      : super(key: key);

  @override
  State<PercentageBreakdown> createState() => _PercentageBreakdownState();
}

class _PercentageBreakdownState extends State<PercentageBreakdown> {
  String removeDecimalZeroFormat(double n) {
    return n.toStringAsFixed(n.truncateToDouble() == n ? 0 : 1);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ...breakdownPercentages.map(
            (p) => PercentageButton(
              percentage:
                  '${removeDecimalZeroFormat(p.method == "Pension" ? widget.pensionPercentage : widget.taxPercentage * 100)}%',
              type: p.method,
              isSelected: p.isSelected,
              onPress: () => setState(() {
                breakdownPercentages.forEach(
                  (perc) {
                    perc.isSelected = false;
                  },
                );
                p.isSelected = true;
              }),
            ),
          )
        ],
      ),
    );
  }
}
