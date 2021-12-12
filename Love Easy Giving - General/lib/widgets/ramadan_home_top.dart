
import 'package:flutter/material.dart';
import 'package:leggenerral/Constants/colors.dart';
import 'package:leggenerral/widgets/text_widget.dart';

import 'custom_spacer.dart';

Column ramadanHomeTop({
  @required String title,
  @required String subtitle,

}) {
  return Column(
    children: [
              appText(
                  text: title,
                  fontSize: 25,
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
