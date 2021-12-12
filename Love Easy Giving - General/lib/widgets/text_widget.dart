import 'package:flutter/material.dart';

Align appText({
  @required String text,
  @required double fontSize,
  TextDecoration decoration,
  Color color = Colors.white,
  TextAlign align = TextAlign.left,
  FontStyle fontStyle = FontStyle.normal,
  Alignment alignment = Alignment.topLeft,
  FontWeight fontWeight = FontWeight.normal,
}) {
  return Align(
    alignment: alignment,
    child: Text(
      text,
      textAlign: align,
      style: TextStyle(
        color: color,
        fontFamily: 'Futura',
        fontStyle: fontStyle,
        fontSize: fontSize,
        fontWeight: fontWeight,
        decoration: decoration,
      ),
    ),
  );
}
