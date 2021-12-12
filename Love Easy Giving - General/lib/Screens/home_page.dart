import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Controller/app_controller.dart';
import '../Constants/colors.dart';
import '../widgets/alert_widgets.dart';
import '../widgets/custom_spacer.dart';
import '../widgets/home_screen_gestures.dart';
import '../widgets/screen_decor.dart';

/// Hajj & Ramadan can't be true at same time.
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final MyAppController _appController = Get.find();

  @override
  void initState() {
    super.initState();
    _appController.isFireStoreConnected().then((value) {
      print(_appController.isRamadan.value);
      print(_appController.isHajj.value);
      print(_appController.isJummah.value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldColor,
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              topDecor(height: 160.5, width: 321),
              vspace(height: 20),
              Obx(
                () => Container(
                  width: 300,
                  color: _appController.isRamadan.value &&
                          !_appController.isHajj.value
                      ? Colors.grey
                      : !_appController.isRamadan.value &&
                              !_appController.isHajj.value
                          ? Colors.grey
                          : null,
                  child: HomeGestures(
                    child: 'assets/images/LoveHajj/LoveHajjWhite.png',
                    onTap: _appController.isHajj.value &&
                            _appController.isRamadan.value == false
                        ? () => Get.toNamed('/hajj', parameters: {
                              'app': 'general',
                            })
                        : () => showToast(
                            message:
                                'Looks like the time of Hajj is not arrived yet.'),
                  ),
                ),
              ),
              vspace(height: 20),
              HomeGestures(
                child: 'assets/images/LoveJummah/lovejummah.png',
                onTap: () => Get.toNamed(
                  '/jummah',
                  parameters: {'app': 'general'},
                ),
              ),
              vspace(height: 20),
              Obx(
                () => Container(
                  width: 300,
                  color: _appController.isHajj.value &&
                          _appController.isRamadan.value == false
                      ? Colors.grey
                      : !_appController.isRamadan.value &&
                              !_appController.isHajj.value
                          ? Colors.grey
                          : null,
                  child: HomeGestures(
                    child: 'assets/images/LoveRamadan/LoveRamadanWhite.png',
                    onTap: _appController.isRamadan.value &&
                            !_appController.isHajj.value
                        ? () => Get.toNamed('/ramadan', parameters: {
                              'app': 'general',
                            })
                        : () => showToast(
                            message:
                                'Looks like the time of Ramadan is not arrived yet.'),
                  ),
                ),
              ),
              vspace(height: 20),
              bottomDecor(height: 160.5, width: 321),
            ],
          ),
        ),
      ),
    );
  }
}
