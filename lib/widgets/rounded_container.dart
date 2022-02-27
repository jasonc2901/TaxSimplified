import 'package:flutter/material.dart';

class RoundedWidget extends StatefulWidget {
  final Color backgroundColor;
  final Widget childWidget;
  final double widgetHeight;
  RoundedWidget(
      {Key? key,
      required this.backgroundColor,
      required this.childWidget,
      required this.widgetHeight})
      : super(key: key);

  @override
  State<RoundedWidget> createState() => _RoundedWidgetState();
}

class _RoundedWidgetState extends State<RoundedWidget> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Container(
      height: widget.widgetHeight,
      width: width,
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: new BorderRadius.only(
          bottomLeft: const Radius.circular(40.0),
          bottomRight: const Radius.circular(40.0),
        ),
      ),
      child: widget.childWidget,
    );
  }
}
