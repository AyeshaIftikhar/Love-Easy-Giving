import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Constants/colors.dart';
import '../../styles/button_styles.dart';
import '../../widgets/const_widgets.dart';
import '../../widgets/custom_spacer.dart';
import '../../widgets/screen_decor.dart';
import '../../widgets/text_widget.dart';

// ignore: must_be_immutable
class LoveHajj extends StatelessWidget {
  var parameters = Get.parameters;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            loveHajjConsts(
              logo: 'assets/images/LoveHajj/lovehajjlogo.png',
              width: 321,
              height: 160.5,
              logoHeight: 170,
              logoWidth: 195,
            ),
            vspace(height: 16),
            Container(
              width: 186,
              height: 49,
              child: OutlinedButton(
                  onPressed: () {
                    Get.offNamed("/hajjHome",
                        arguments: Colors.white,
                        parameters: {
                          'title': 'CHOOSE YOUR QURBANI',
                          'mode': 'qurbani',
                          'app_mode': 'Hajj',
                          'app': parameters['app'],
                        });
                  },
                  style: outlinebutton(
                    borderColor: hborder,
                  ),
                  child: appText(
                      text: "QURBANI",
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      alignment: Alignment.center,
                      color: htextColor)),
            ),
            vspace(height: 20),
            Container(
              width: 188,
              height: 49,
              child: OutlinedButton(
                  onPressed: () {
                    Get.toNamed("/hajjHome",
                        arguments: Colors.white,
                        parameters: {
                          'title': 'CHOOSE YOUR CHARITY',
                          'mode': 'charity',
                          'app_mode': 'Hajj',
                          'app': parameters['app'],
                        });
                  },
                  style: outlinebutton(
                    borderColor: hborder,
                  ),
                  child: appText(
                      text: "SCHEDULE SADQAH",
                      fontSize: 14,
                      align: TextAlign.center,
                      fontWeight: FontWeight.bold,
                      alignment: Alignment.center,
                      color: htextColor)),
            ),
            Container(
              width: 259,
              margin:
                  const EdgeInsets.only(top: 20, bottom: 0, left: 0, right: 0),
              padding: const EdgeInsets.only(left: 3, right: 5, bottom: 0),
              child: Column(
                children: [
                  appText(
                    text:
                        '“No good deeds are better than those done in first ten days of Dhul Hijjah…”',
                    align: TextAlign.center,
                    fontSize: 16,
                    color: htextDark,
                    alignment: Alignment.center,
                    fontWeight: FontWeight.w500,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 50.0, right: 50, top: 20),
                    child: appText(
                      text: 'Bukhari',
                      align: TextAlign.center,
                      fontSize: 15,
                      color: htextDark,
                      alignment: Alignment.center,
                    ),
                  ),
                ],
              ),
            ),
            vspace(height: 20),
            bottomDecor(width: 321, height: 160.5),
          ],
        ),
      ),
    );
  }
}
