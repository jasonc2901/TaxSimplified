import 'package:flutter/material.dart';
import '../constants.dart';

class PercentageButton extends StatefulWidget {
  final String percentage;
  final String type;
  final void Function() onPress;
  bool isSelected;

  PercentageButton(
      {Key? key,
      required this.percentage,
      required this.type,
      required this.isSelected,
      required this.onPress})
      : super(key: key);

  @override
  State<PercentageButton> createState() => _PercentageButtonState();
}

class _PercentageButtonState extends State<PercentageButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onPress,
      child: Column(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25.0),
              boxShadow: [
                BoxShadow(color: greyColor, spreadRadius: 0.2, blurRadius: 0.6)
              ],
              color: widget.isSelected ? darkPurple : Colors.white,
            ),
            child: Center(
              child: Text(
                widget.percentage,
                style: TextStyle(
                  color: widget.isSelected ? Colors.white : greyColor,
                  fontSize: 32.0,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          Text(
            widget.type,
            style: TextStyle(
              fontSize: 22.0,
            ),
          )
        ],
      ),
    );
  }
}
