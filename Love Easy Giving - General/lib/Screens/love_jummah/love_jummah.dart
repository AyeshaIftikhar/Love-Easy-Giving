import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Constants/colors.dart';
import '../../styles/button_styles.dart';
import '../../widgets/const_widgets.dart';
import '../../widgets/custom_spacer.dart';
import '../../widgets/screen_decor.dart';
import '../../widgets/text_widget.dart';

// ignore: must_be_immutable
class LoveJummah extends StatelessWidget {
  var _parameters = Get.parameters;
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
                logo: 'assets/images/LoveJummah/lovejummahlogo.png'),
            vspace(height: 55),
            Container(
              width: 150,
              height: 40,
              child: OutlinedButton(
                onPressed: () {
                  print('LoveJummah/Clicked');
                  Get.offNamed("/Uhome",
                      arguments: loveJummahScaffold,
                      parameters: {
                        'title': 'Love Jummah',
                        'app_mode': 'Jummah',
                        'app': _parameters['app'],
                      });
                },
                child: Text('ENTER'),
                style: outlinebutton(
                  radius: 10,
                  textColor: textColor,
                  borderColor: selectColor,
                  primary: textColor,
                  weight: FontWeight.bold,
                ),
              ),
            ),
            vspace(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 50.0, right: 50, top: 30),
              child: Center(
                child: appText(
                  text:
                      'Charity given during the day of Jumu’ah is greater (in reward) than any other day',
                  align: TextAlign.center,
                  fontSize: 16,
                  alignment: Alignment.center,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 50.0, right: 50, top: 30),
              child: Center(
                child: appText(
                  text: 'The Prophet Muhammad',
                  align: TextAlign.center,
                  fontSize: 16,
                  alignment: Alignment.center,
                ),
              ),
            ),
            vspace(height: 45),
            bottomDecor(width: 321, height: 160.5),
          ],
        ),
      ),
    );
  }
}
