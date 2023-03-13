import '../Constants/colors.dart';
import 'package:flutter/material.dart';

InputDecoration inputDecoration({
  String? label,
  bool filled = false,
  int errorMaxLines = 1,
  InputBorder? inputBorder,
  Color fillColor = Colors.white,
  Color focusColor = Colors.white,
  Color textColor = Colors.white,
  Color borderColor = Colors.white,
  Color errorColor = Colors.white,
  Color helperColor = Colors.white,
  Widget? suffix,
  String? hint,
  String? error, 
  String? helper,
}) {
  return InputDecoration(
    filled: filled,
    suffix: suffix,
    hintText: hint,
    labelText: label,
    helperText: helper,
    fillColor: fillColor,
    focusColor: focusColor,
    errorMaxLines: errorMaxLines,
    hintStyle: TextStyle(fontFamily: 'Futura', color: textColor),
    labelStyle: TextStyle(fontFamily: 'Futura', color: textColor),
    helperStyle: TextStyle(fontFamily: 'Futura', color: helperColor),
    errorStyle: TextStyle(
      fontFamily: 'Futura',
      color: errorColor,
    ),
    counterStyle: TextStyle(
      fontFamily: 'Futura',
      color: textColor,
    ),
    border: inputBorder ??
        UnderlineInputBorder(
          borderSide: BorderSide(color: borderColor),
        ),
    enabledBorder: inputBorder ??
        UnderlineInputBorder(
          borderSide: BorderSide(color: borderColor),
        ),
    focusedBorder: inputBorder ??
        UnderlineInputBorder(
          borderSide: BorderSide(color: borderColor),
        ),
    focusedErrorBorder: inputBorder ??
        UnderlineInputBorder(
          borderSide: BorderSide(color: borderColor),
        ),
    errorBorder: inputBorder ??
        UnderlineInputBorder(
          borderSide: BorderSide(color: borderColor),
        ),
    disabledBorder: inputBorder ??
        UnderlineInputBorder(
          borderSide: BorderSide(color: borderColor),
        ),
  );
}

dropDownStyle({
  required Color backgroundColor,
}) => InputDecoration(
      errorStyle: TextStyle(
          fontFamily: 'Futura',
          color:
              selectColor
      ),
      border: UnderlineInputBorder(
        borderSide: BorderSide(
            color:
                selectColor),
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(
            color:
                selectColor),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
            color:selectColor),
      ),
      focusedErrorBorder: UnderlineInputBorder(borderSide: BorderSide(color:selectColor),),
      errorBorder: UnderlineInputBorder(borderSide: BorderSide(color:selectColor),),
      disabledBorder: UnderlineInputBorder(borderSide: BorderSide(color:selectColor),),
    );
