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
              vspace(height: 50),
              appLogo(),
              vspace(height: 30),
              // Center(
              //   child: Container(
              //     height: 70,
              //     width: 70,
              //     decoration: BoxDecoration(
              //       // border: Border.all(color: primaryColor),
              //       // borderRadius: BorderRadius.circular(12),
              //       image: DecorationImage(
              //         image: AssetImage('assets/slogo.png'),
              //       ),
              //     ),
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "Powered By",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 15,
                    fontFamily: 'Futura',
                    // fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.all(5.0),
              //   child: Text(
              //     "Forgotten Women",
              //     textAlign: TextAlign.center,
              //     style: TextStyle(
              //       color: primaryColor,
              //       fontSize: 17,
              //       fontFamily: 'Futura',
              //       fontWeight: FontWeight.bold,
              //     ),
              //   ),
              // ),
              Center(
                child: Container(
                  height: 120,
                  width: 150,
                  decoration: BoxDecoration(
                    // border: Border.all(color: primaryColor),
                    // borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: AssetImage('assets/slogo.png'),
                    ),
                  ),
                ),
              ),
              // vspace(height: 70),
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
                            fontSize: 20,
                            fontFamily: 'Futura',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  )),
              vspace(height: 50),
              bottomDecor(height: 160.5, width: 321),
            ],
          ),
        ),
      ),
    );
  }
}
