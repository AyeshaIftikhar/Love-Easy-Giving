import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Constants/colors.dart';
import '../../styles/button_styles.dart';
import '../../widgets/const_widgets.dart';
import '../../widgets/custom_spacer.dart';
import '../../widgets/screen_decor.dart';
import '../../widgets/text_widget.dart';

class HThanks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            loveHajjConsts(
              width: 321, height: 160.5,
              logoHeight: 90,
              logoWidth: 410,
                logo: 'assets/images/LoveHajj/lovehajjlongstrip.png'),
            Container(
              width: 327,
              margin: EdgeInsets.only(top: 30,),
              padding: EdgeInsets.only(left:20, right:20),
              child: appText(
                text: 'Thank you for your kind donation'.toUpperCase(),
                align: TextAlign.center,
                fontSize: 20,
                color: htextDark,
                alignment: Alignment.center,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              width:330,
              margin: EdgeInsets.only(top: 45,),
              padding: EdgeInsets.only(left: 16.0, right: 16,),
              child: Center(
                child: appText(
                  text: 'The Prophet (peace and blessings be upon him)\n said, “There are no days in which righteous deeds are more beloved to Allah \nthan these ten days.”',
                  align: TextAlign.center,
                  fontSize: 14,
                  color: htextDark,
                  alignment: Alignment.center,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 50.0, right: 50, top: 30),
              child: appText(
                text:'Schedule daily amounts for the first 10 days of Dhul Hijjah',
                align: TextAlign.center,
                fontSize: 14,
                color: htextDark,
                alignment: Alignment.center,
                fontWeight: FontWeight.bold,
              ),
            ),
            vspace(height: 30),
            Container(
              width: 164,
              height: 41,
              child: OutlinedButton(
                  onPressed: () {
                    Get.offNamed(
                      "/homePage",
                    );
                  },
                  style: outlinebutton(
                    borderColor: htextDark,
                    borderwidth:2,
                    radius: 10,
                  ),
                  child: appText(
                      text: "SCHEDULE SADQAH",
                      fontSize: 12.2,
                      fontWeight: FontWeight.bold,
                      alignment: Alignment.center,
                      align: TextAlign.center,
                      color: htextDark)),
            ),
            vspace(height: 30),
            bottomDecor(width: 321, height: 160.5),
          ],
        ),
      ),
    );
  }
}
