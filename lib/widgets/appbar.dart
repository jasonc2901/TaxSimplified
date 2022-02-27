import 'package:flutter/material.dart';
import '../constants.dart';

class SystemAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Color color;
  final Color textColor;
  const SystemAppBar(
      {Key? key,
      required this.title,
      required this.color,
      required this.textColor})
      : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(50);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: color,
      foregroundColor: textColor,
      title: Text(
        title,
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.w400,
          fontSize: 32.0,
        ),
      ),
      shadowColor: Colors.transparent,
    );
  }
}
