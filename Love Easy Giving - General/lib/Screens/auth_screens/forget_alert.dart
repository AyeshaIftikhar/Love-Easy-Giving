import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Constants/colors.dart';
import '../../styles/button_styles.dart';
import '../../widgets/text_widget.dart';
import '../../widgets/custom_spacer.dart';
import '../../widgets/screen_decor.dart';

class ForgetAlertScreen extends StatefulWidget {
  @override
  _ForgetAlertScreenState createState() => _ForgetAlertScreenState();
}

class _ForgetAlertScreenState extends State<ForgetAlertScreen> {
  String email = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            topDecor(width: 321, height: 160.5),
            vspace(height: 40),
            Padding(
              padding: const EdgeInsets.only(left: 30.0, right: 30),
              child: appText(
                text: 'Check Inbox',
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            vspace(height: 30),
            Padding(
              padding: const EdgeInsets.only(left: 30.0, right: 30),
              child: appText(
                text: 'We have sent a reset password link to the email addres',
                fontSize: 18,
              ),
            ),
            vspace(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 30.0, right: 30),
              child: appText(
                text: email,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            vspace(height: 30),
            Padding(
              padding: const EdgeInsets.only(left: 30.0, right: 30),
              child: appText(
                text:
                    'If you do not receive the email within 5 minutes, then please check your spam folder.',
                fontSize: 18,
              ),
            ),
            vspace(height: 40),
            Container(
              width: 250,
              padding: const EdgeInsets.only(left: 30.0, right: 30),
              child: ElevatedButton(
                onPressed: () => Get.toNamed('/login'),
                child: appText(
                    text: 'Close',
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    alignment: Alignment.center,
                    color: primaryColor),
                style: elevatedButton(
                  primary: Colors.white,
                ),
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
