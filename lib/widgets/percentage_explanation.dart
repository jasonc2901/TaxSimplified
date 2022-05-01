import 'package:flutter/material.dart';
import 'package:tax_simplified/constants.dart';

class PercentageExplanationWidget extends StatefulWidget {
  final String type;
  PercentageExplanationWidget({Key? key, required this.type}) : super(key: key);

  @override
  State<PercentageExplanationWidget> createState() =>
      _PercentageExplanationWidgetState();
}

class _PercentageExplanationWidgetState
    extends State<PercentageExplanationWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: Container(
          width: 500,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 1),
                blurRadius: 5,
                color: Colors.black.withOpacity(0.3),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Spacer(),
                    Text(
                      widget.type,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: darkPurple,
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      "£28,000 - 20%",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: greyColor,
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Spacer(),
                  ],
                ),
                Text(
                  "- £5000",
                  style: TextStyle(
                    color: darkPurple,
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                  ),
                )
              ],
            ),
          )),
    );
  }
}
