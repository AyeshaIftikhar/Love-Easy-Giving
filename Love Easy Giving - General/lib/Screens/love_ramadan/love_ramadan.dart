import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Constants/colors.dart';
import '../../styles/button_styles.dart';
import '../../widgets/const_widgets.dart';
import '../../widgets/custom_spacer.dart';
import '../../widgets/screen_decor.dart';
import '../../widgets/text_widget.dart';

// ignore: must_be_immutable
class LoveRamadan extends StatelessWidget {
  var _parameters = Get.parameters;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ramadanScaffoldColor,
      // persistentFooterButtons: [copyrightwidget()],
      body: SingleChildScrollView(
          child: Column(
        children: [
          loveRamadanConsts(width: 321, height: 160.5,logo: 'assets/images/LoveRamadan/loveramadan.png'),
          vspace(height:42),
          Container(
            width: 150,
            height: 40,
            child: OutlinedButton(
              onPressed: () {
                print('LoveJummah/Clicked');
                Get.offNamed("/Rhome",
                    arguments: ramadanScaffoldColor,
                    parameters: {
                      'title': 'Choose Your Charity',
                      'subtitle': 'Sadqah / Zakah option next page',
                      'app_mode': 'Ramadan',
                      'task_mode': 'charity',
                      'app': _parameters['app'],
                });
              },
              child:appText(text: 'ENTER', fontSize: 17, align: TextAlign.center, alignment: Alignment.center, fontWeight: FontWeight.bold),
              style: outlinebutton(
                radius: 10,
                textColor: textColor,
                borderColor: selectColor,
                primary: textColor,
                weight: FontWeight.bold,
              ),
            ),
          ),
          vspace(height: 25),
          Padding(
            padding: const EdgeInsets.only(left: 50.0, right: 50, top: 35),
            child: Center(
              child: appText(
                text:
                    '“Those who spend their wealth in charity day and night, secretly and openly - their reward is with their Lord and their will be no fear for them, nor will they grieve.”',
                align: TextAlign.center,
                fontSize: 14,
                alignment: Alignment.center,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 50.0, right: 50, top: 30),
            child: Center(
              child: appText(
                text: 'Quran 2.274',
                align: TextAlign.center,
                fontSize: 13,
                alignment: Alignment.center,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          vspace(height: 43),
          bottomDecor(width: 321, height: 160.5,),
        ],
      )),
    );}
}