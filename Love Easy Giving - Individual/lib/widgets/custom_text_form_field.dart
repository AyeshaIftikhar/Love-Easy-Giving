import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatelessWidget {
  final bool filled;
  final bool autoFocus;
  final bool isPassword;
  final int minLine;
  final int maxLines;
  final int maxLength;
  final int errorMaxLines;
  final String hint;
  final String label;
  final String error;
  final String initialVal;
  final Color fillColor;
  final Color decorColor;
  final Color errorColor;
  final Color focusColor;
  final Color cursorColor;
  final Color borderColor;
  final Color counterColor;
  final Color typedTextColor;
  final Widget prefixIcon;
  final Widget suffixIcon;
  final Function onTap;
  final Function validator;
  final Function onChanged;
  final Function onEditingComplete;
  final InputBorder inputBorder;
  final double hfont;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final TextEditingController controller;
  final MaxLengthEnforcement lengthEnforcement;
  final List<FilteringTextInputFormatter> inputFormatters;
  CustomTextFormField({
    this.label,
    @required this.maxLines,
    this.keyboardType,
    @required this.typedTextColor,
    this.hint,
    this.hfont,
    this.onTap,
    this.error,
    this.minLine,
    this.maxLength,
    this.onChanged,
    this.validator,
    this.controller,
    this.prefixIcon,
    this.suffixIcon,
    this.decorColor,
    this.errorColor,
    this.initialVal,
    this.borderColor,
    this.inputBorder,
    this.counterColor,
    this.inputFormatters,
    this.textInputAction, // with onChanged
    this.onEditingComplete, // with text editing controller
    this.errorMaxLines = 1,
    this.filled = false,
    this.autoFocus = false,
    this.isPassword = false,
    this.fillColor = Colors.grey,
    this.focusColor = Colors.white,
    this.cursorColor = Colors.white,
    this.lengthEnforcement = MaxLengthEnforcement.none,
  });
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialVal,
      cursorColor: cursorColor,
      onTap: onTap,
      minLines: minLine,
      maxLines: maxLines,
      validator: validator,
      maxLength: maxLength,
      onChanged: onChanged,
      autofocus: autoFocus,
      controller: controller,
      obscureText: isPassword,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      textInputAction: textInputAction,
      maxLengthEnforcement: lengthEnforcement,
      onEditingComplete: onEditingComplete,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      style: TextStyle(fontFamily: 'Futura', color: typedTextColor),
      decoration: InputDecoration(
        hintText: hint,
        errorText: error,
        labelText: label,
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        filled: filled,
        fillColor: fillColor,
        focusColor: focusColor,
        errorMaxLines: errorMaxLines,
        hintStyle: TextStyle(
          fontFamily: 'Futura',
          fontSize: hfont,
          color: decorColor,
        ),
        labelStyle: TextStyle(
          fontFamily: 'Futura',
          fontSize: hfont,
          color: decorColor,
        ),
        errorStyle: TextStyle(
          fontFamily: 'Futura',
          color: errorColor,
        ),
        counterStyle: TextStyle(
          fontFamily: 'Futura',
          color: counterColor,
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
      ),
    );
  }
}
