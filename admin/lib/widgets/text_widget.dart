import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  const TextWidget({
    Key? key,
    required this.text,
    this.alignment = Alignment.topLeft,
    this.size = 14,
    this.weight = FontWeight.normal,
    this.color = const Color(0xff6B5233),
    this.textAlign = TextAlign.left,
    this.textStyle = FontStyle.normal,
    this.lineHeight = 1.2,
  }) : super(key: key);
  final Alignment alignment;
  final String text;
  final FontWeight weight;
  final double size;
  final Color color;
  final TextAlign textAlign;
  final FontStyle textStyle;
  final double lineHeight;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: Text(
        text,
        textAlign: textAlign,
        style: TextStyle(
          color: color,
          fontSize: size,
          fontWeight: weight,
          fontFamily: 'Futura',
          fontStyle: textStyle,
          height: lineHeight,
        ),
      ),
    );
  }
}
