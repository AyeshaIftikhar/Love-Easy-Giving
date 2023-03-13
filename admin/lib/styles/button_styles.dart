import 'package:flutter/material.dart';

outlinebutton({
  double radius = 12.0,
  double borderwidth = 1,
  double fontsize = 17.0,
  Color surface = Colors.grey,
  Color primary = Colors.white,
  Color textColor = Colors.white,
  Color borderColor = Colors.white,
  FontWeight weight = FontWeight.normal,
  FontStyle fontStyle = FontStyle.normal,
}) =>
    OutlinedButton.styleFrom(
      onSurface: surface,
      primary: primary,
      side: BorderSide(width: borderwidth, color: borderColor),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(radius)),
      ),
      textStyle: TextStyle(
        fontFamily: 'Futura',
        fontSize: fontsize,
        color: textColor,
        fontWeight: weight,
        fontStyle: fontStyle,
      ),
    );

elevatedButton({
  double fontsize = 17,
  double elevation = 2.0,
  double borderRadius = 12,
  Color surface = Colors.grey,
  Color? primary,
  Color onPrimary = Colors.white,
  FontWeight weight = FontWeight.normal,
  FontStyle fontStyle = FontStyle.normal,
}) =>
    ElevatedButton.styleFrom(
      elevation: elevation,
      onPrimary: onPrimary,
      onSurface: surface,
      primary: primary ?? const Color(0xffB08850),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
      ),
      textStyle: TextStyle(
        fontFamily: 'Futura',
        fontSize: fontsize,
        fontWeight: weight,
        fontStyle: fontStyle,
      ),
    );

textButton({
  double fontsize = 17,
  double borderRadius = 12,
  Color surface = Colors.grey,
  Color primary = Colors.white,
  FontWeight weight = FontWeight.normal,
  FontStyle fontStyle = FontStyle.normal,
}) =>
    TextButton.styleFrom(
        onSurface: surface,
        primary: primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
        ),
        textStyle: TextStyle(
          fontFamily: 'Futura',
          fontSize: fontsize,
          fontWeight: weight,
          fontStyle: fontStyle,
        ));

FloatingActionButtonThemeData floatingButton({
  double elevation = 2.0,
  Color? background,
  Color foreground = Colors.white,
}) {
  return FloatingActionButtonThemeData(
    elevation: elevation,
    foregroundColor: foreground,
    backgroundColor: background ?? const Color(0xffB08850),
  );
}

AppBarTheme appbar({
  Color? color,
  Color? titleColor,
  Color? iconColor,
  double? fontsize,
  double elevation = 0.0,
  bool centerTitle = false,
  FontWeight weight = FontWeight.normal,
  FontStyle fontStyle = FontStyle.normal,
}) {
  return AppBarTheme(
    elevation: elevation,
    centerTitle: centerTitle,
    color: color ?? Colors.white.withAlpha(0),
    iconTheme: IconThemeData(
      color: iconColor ?? const Color(0xffB08850),
    ),
    actionsIconTheme: IconThemeData(
      color: iconColor ?? const Color(0xffB08850),
    ),
    titleTextStyle: TextStyle(
      fontFamily: 'Futura',
      fontSize: fontsize,
      fontWeight: weight,
      fontStyle: fontStyle,
      color: titleColor ?? const Color(0xffB08850),
    ),
  );
}
