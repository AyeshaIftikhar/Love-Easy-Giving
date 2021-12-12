
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leggenerral/widgets/text_widget.dart';
import './app_logo.dart';
import './custom_spacer.dart';
import './screen_decor.dart';


Column constWidgets({
  @required double height,
  @required double width,
}) {
  return Column(
    children: [
      topDecor(height: height, width: width),
      vspace(height: 30),
      Align(
        alignment: Alignment.topLeft,
        child: Padding(
          padding: EdgeInsets.only(left: 25.0),
          child: Text(
            "SIGN-UP TO",
            style: TextStyle(
              fontSize: 21,
              fontFamily: 'Futura',
              color: Colors.white,
            ),
          ),
        ),
      ),
      appLogoWhite(),
    ],
  );
}
Column customTop({
  @required Color color,
  @required String text,
  @required double fontSize,
  Color textColor = Colors.white,
  TextAlign align = TextAlign.left,
  FontStyle fontStyle = FontStyle.normal,
  Alignment alignment = Alignment.topLeft,
  FontWeight fontWeight = FontWeight.normal,
}) {
  return Column(
    children: [
      Row(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: IconButton(
              tooltip: 'Exit',
              alignment: Alignment.topLeft,
              icon: Icon(
                Icons.arrow_back_ios,
                color: color,
              ),
              onPressed: () => Get.back(),
            ),
          ),
          Container(
            width: 270,
            margin: EdgeInsets.only(
              top: fontSize >= 28 ? 30: 0
            ),
            child: appText(
                    text: text,
                    fontSize: fontSize,
                    color: textColor,
                    fontWeight: fontWeight,
                    align: align,
                    alignment: alignment),
          ),
        ],
      ),
    ],
  );
}


/// Love Jummah
Column loveJummahConsts({
  @required String logo,
  @required double height,
  @required double width,
}) {
  return Column(
    children: [
      topDecor(
        height: height,
        width: width,
      ),
      vspace(height: 30),
      loveJummahLogo(logo: logo),
    ],
  );
}

Column loveRamadanConsts({
  @required String logo,
  @required double height,
  @required double width,
}) {
  return Column(
    children: [
      topDecor(
        width: width, height: height,
      ),
      vspace(height: 10),
      loveJummahLogo(logo: logo),
    ],
  );
}

/// Love Hajj
Column loveHajjConsts(
{
  @required String logo,
  @required double height,
  @required double width,
  @required double logoWidth,
  @required double logoHeight,
}
) {
  return Column(
    children: [
      topDecor(
        width: width, height: height,
      ),
      loveHajjLogo(logo: logo, logoHeight: logoHeight, logoWidth: logoWidth, ),
    ],
  );
}