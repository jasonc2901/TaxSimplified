import 'package:flutter/material.dart';

import '../constants.dart';

class RoundedButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  const RoundedButtonWidget(
      {Key? key, required this.onPressed, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Center(
      child: Padding(
        padding: EdgeInsets.only(bottom: height * 0.05),
        child: ElevatedButton(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              text,
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
          ),
          onPressed: onPressed,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(orangeColor),
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            shadowColor: MaterialStateProperty.all<Color>(Colors.transparent),
            overlayColor: MaterialStateProperty.all<Color>(Colors.transparent),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
                side: BorderSide(color: orangeColor),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
