import 'package:flutter/material.dart';

import '../constants.dart';

class RoundedButtonNoPaddingWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final Color color;
  const RoundedButtonNoPaddingWidget(
      {Key? key,
      required this.onPressed,
      required this.text,
      required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Center(
      child: ElevatedButton(
        child: Text(
          text,
          style: TextStyle(
            fontSize: 18.0,
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
    );
  }
}
