import '../Constants/colors.dart';
import './text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';

Widget copyrightwidget({Color color = textColor}) {
  return Padding(
    padding: const EdgeInsets.only(top: 8.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        appText(
          text: 'Powered by',
          fontSize: 12,
          alignment: Alignment.center,
          color: color,
        ),
        appText(
          text: 'Forgotten Women',
          fontSize: 15,
          color: color,
          alignment: Alignment.center,
          fontWeight: FontWeight.bold,
        ),
      ],
    ),
  );
}
