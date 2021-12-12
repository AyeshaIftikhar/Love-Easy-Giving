import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Constants/colors.dart';

Padding privacyText({
  @required String text,
  double fontSize,
  TextDecoration decoration,
  TextDecorationStyle decorationStyle,
  Color color = Colors.white,
  Color decorationColor = Colors.white,
  Alignment alignment = Alignment.topLeft,
  FontWeight fontWeight = FontWeight.normal,
  FontStyle fontStyle = FontStyle.normal,
}) {
  return Padding(
    padding: const EdgeInsets.only(top: 15.0),
    child: Align(
      alignment: alignment,
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontFamily: 'Futura',
          fontWeight: fontWeight,
          fontStyle: fontStyle,
          fontSize: fontSize,
          decoration: decoration,
          decorationStyle: decorationStyle,
          decorationColor: decorationColor,
        ),
      ),
    ),
  );
}

InkWell privacyLink({
  @required String link,
}) {
  return InkWell(
      child: Align(
        alignment: Alignment.topLeft,
        child: Text(
          link,
          style: TextStyle(
              color: textColor,
              fontFamily: 'Futura',
              decoration: TextDecoration.underline),
        ),
      ),
      onTap: () => launch(link));
}
