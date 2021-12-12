import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Constants/colors.dart';
import '../../styles/button_styles.dart';
import '../../widgets/const_widgets.dart';
import '../../widgets/custom_spacer.dart';
import '../../widgets/screen_decor.dart';
import '../../widgets/text_widget.dart';

// ignore: must_be_immutable
class RThanksScreen extends StatelessWidget {
  var _parameters = Get.parameters;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ramadanScaffoldColor,
      body: SingleChildScrollView(
          child: Column(
        children: [
          loveRamadanConsts(
              height: 160.5,
              width: 321,
              logo: 'assets/images/LoveRamadan/loveramadan.png'),
          Padding(
            padding: const EdgeInsets.only(left: 40.0, right: 40, top: 25),
            child: Center(
              child: appText(
                text: 'WITH',
                align: TextAlign.center,
                fontSize: 17,
                alignment: Alignment.center,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 50.0, right: 50, top: 20),
            child: Center(
              child: appText(
                text: _parameters['mosque_name'],
                align: TextAlign.center,
                fontSize: 20,
                alignment: Alignment.center,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 50.0, right: 50, top: 30),
            child: Center(
              child: appText(
                text:
                    'Thank you for your kind donation, may it be accepted and be means of ease both in this life and the hereafter.',
                align: TextAlign.center,
                fontSize: 13,
                alignment: Alignment.center,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 50.0, right: 50, top: 20),
            child: Center(
              child: appText(
                  text: 'Ameen',
                  align: TextAlign.center,
                  fontSize: 13.5,
                  alignment: Alignment.center,
                  fontWeight: FontWeight.bold),
            ),
          ),
          vspace(height: 30),
          Container(
            height: 40,
            child: OutlinedButton(
              onPressed: () {
                print('LoveRamadan/Clicked');
                Get.offNamed('/homePage');
              },
              child: Text('DONATE AGAIN'),
              style: outlinebutton(
                  radius: 10,
                  textColor: textColor,
                  borderColor: selectColor,
                  primary: textColor,
                  weight: FontWeight.bold),
            ),
          ),
          vspace(height: 40),
          bottomDecor(
            height: 160.5,
            width: 321,
          ),
        ],
      )),
    );
  }
}
