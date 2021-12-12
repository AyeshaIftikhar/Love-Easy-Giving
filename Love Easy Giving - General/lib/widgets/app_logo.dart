import 'package:flutter/material.dart';

Container appLogo() {
  return Container(
    child: Image.asset('assets/images/LoveEasyGiving/easylovegiving.png'),
  );
}

Container appLogoWhite() {
  return Container(
    child: Image.asset('assets/images/LoveEasyGiving/easylovegivingwhite.png'),
  );
}

Center loveJummahLogo({
  @required String logo,
}) {
  return Center(
    child: Container(
      height: 110,
      child: Image.asset(logo),
    ),
  );
}

Center loveRamadanLogo({
  @required String logo,
}) {
  return Center(
    child: Container(
      // height: 110,
      child: Image.asset(logo),
    ),
  );
}

Center loveHajjLogo({
  @required String logo,
  @required double logoWidth,
  @required double logoHeight,
}) {
  return Center(
    child: Image.asset(
      logo,
      height: logoHeight,
      width: logoWidth,
    ),
  );
}