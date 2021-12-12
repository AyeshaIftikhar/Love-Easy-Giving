import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Constants/colors.dart';
import '../../styles/button_styles.dart';
import '../../widgets/const_widgets.dart';
import '../../widgets/custom_spacer.dart';
import '../../widgets/screen_decor.dart';
import '../../widgets/text_widget.dart';

class RThanksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ramadanScaffoldColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            loveRamadanConsts(
                width: 321,
                height: 160.5,
                logo: 'assets/images/LoveRamadan/loveramadan.png'),
            Container(
              width: 322,
              padding: const EdgeInsets.only(left: 20, right: 20, top: 67),
              child: appText(
                text:
                    'Thank you for your kind donation, may it be accepted and be means of ease both in this life and the hereafter.',
                align: TextAlign.center,
                fontSize: 13,
                alignment: Alignment.center,
                fontWeight: FontWeight.w500,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 45),
              child: Center(
                child: appText(
                    text: 'Ameen',
                    align: TextAlign.center,
                    fontSize: 13.5,
                    alignment: Alignment.center,
                    fontWeight: FontWeight.bold),
              ),
            ),
            vspace(height: 50),
            Container(
              height: 45,
              width: 156,
              child: OutlinedButton(
                onPressed: () {
                  print('LoveRamadan/Clicked');
                  Get.offNamed('/homePage');
                },
                child: appText(
                    text: 'DONATE AGAIN',
                    fontSize: 13,
                    align: TextAlign.center,
                    alignment: Alignment.center,
                    fontWeight: FontWeight.bold),
                style: outlinebutton(
                    radius: 10,
                    textColor: textColor,
                    borderColor: selectColor,
                    primary: textColor,
                    weight: FontWeight.bold),
              ),
            ),
            vspace(height: 50),
            bottomDecor(width: 321, height: 160.5),
          ],
        ),
      ),
    );
  }
}
