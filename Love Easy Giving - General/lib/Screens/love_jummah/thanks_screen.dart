import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Constants/colors.dart';
import '../../styles/button_styles.dart';
import '../../widgets/const_widgets.dart';
import '../../widgets/custom_spacer.dart';
import '../../widgets/screen_decor.dart';
import '../../widgets/text_widget.dart';

class JThanksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: loveJummahScaffold,
      body: SingleChildScrollView(
        child: Column(
          children: [
            loveJummahConsts(
                width: 321,
                height: 160.5,
                logo: 'assets/images/LoveJummah/loveJummahLeft.png'),
            Padding(
              padding: const EdgeInsets.only(left: 50.0, right: 50, top: 35),
              child: Center(
                child: appText(
                  text: 'Thank you for your kind donation'.toUpperCase(),
                  align: TextAlign.center,
                  fontSize: 17,
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
                      'May your donation be accepted and be a means of ease both in this life and the hereafter.',
                  align: TextAlign.center,
                  fontSize: 13,
                  alignment: Alignment.center,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 50.0, right: 50, top: 30),
              child: Center(
                child: appText(
                    text: 'Ameen',
                    align: TextAlign.center,
                    fontSize: 16,
                    alignment: Alignment.center,
                    fontWeight: FontWeight.bold),
              ),
            ),
            vspace(height: 20),
            Container(
              height: 40,
              child: OutlinedButton(
                onPressed: () {
                  print('LoveJummah/Clicked');
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
            vspace(height: 30),
            bottomDecor(width: 321, height: 160.5),
          ],
        ),
      ),
    );
  }
}
