import '../Constants/colors.dart';
import './custom_spacer.dart';
import './text_widget.dart';
import 'package:flutter/material.dart';

Column ramadanHomeTop({
  @required String title,
  @required String subtitle,

}) {
  return Column(
    children: [
              appText(
                  text: title,
                  fontSize: 25,
                  // color: htextDark,
                  align: TextAlign.center,
                  alignment: Alignment.center,
                  fontWeight: FontWeight.bold),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: appText(
                    text: subtitle,
                    fontSize: 17,
                    color: subtitleColor,
                    align: TextAlign.center,
                    alignment: Alignment.center,
                ),
              ),
              vspace(height: 20),
    ],
  );
}
