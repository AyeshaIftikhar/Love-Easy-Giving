import '../widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Constants/colors.dart';
import '../Controller/app_controller.dart';
import '../widgets/custom_spacer.dart';
import '../widgets/app_logo.dart';
import '../widgets/screen_decor.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final MyAppController _controller = Get.find();

  @override
  void initState() {
    super.initState();
    _controller.checkUserLoginState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              topDecor(height: 160.5, width: 321),
              vspace(height: 70),
              appLogo(),
              Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: appText(
                  text: 'Powered by:',
                  fontSize: 14,
                  color: htextDark,
                  alignment: Alignment.center,
                ),
              ),
              Image.asset('assets/slogo.png', height: 150),
              // vspace(height: 50),
              vspace(height: 10),
              Obx(() => InkWell(
                    onTap: !_controller.isUserLogin.value
                        ? () => Get.offNamed('/login')
                        : () => Get.offNamed('/homePage'),
                    child: Container(
                      width: 141,
                      height: 41,
                      decoration: BoxDecoration(
                        border: Border.all(color: primaryColor),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "ENTER",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: primaryDark,
                            fontSize: 22,
                            fontFamily: 'Futura',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  )),
              vspace(height: 10),
              bottomDecor(height: 160.5, width: 321),
            ],
          ),
        ),
      ),
    );
  }
}
