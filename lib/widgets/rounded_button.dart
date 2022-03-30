import 'package:flutter/material.dart';

import '../constants.dart';

class RoundedButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final Color color;
  final double padding;

  const RoundedButtonWidget({
    Key? key,
    required this.onPressed,
    required this.text,
    required this.color,
    required this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.only(bottom: padding),
        child: ElevatedButton(
          child: Padding(
            padding: EdgeInsets.all(padding == 0 ? 0 : 12),
            child: Text(
              text,
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
          ),
          onPressed: onPressed,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(color),
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            shadowColor: MaterialStateProperty.all<Color>(Colors.transparent),
            overlayColor: MaterialStateProperty.all<Color>(Colors.transparent),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
                side: BorderSide(color: color),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
