import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leggenerral/widgets/copyright.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Controller/app_controller.dart';
import '../Constants/colors.dart';
import './text_widget.dart';
import './custom_spacer.dart';

// ignore: must_be_immutable
class AppDrawer extends StatelessWidget {
  final MyAppController _app = Get.find();
  Color color;
  String appMode;
  String app;
  AppDrawer({
    @required this.color,
    @required this.appMode,
    @required this.app,
  });
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Stack(
        children: [
          Column(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(color: primaryColor),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: CircleAvatar(
                          radius: 30,
                          backgroundColor: avatarColor,
                          child: Icon(Icons.person, color: Colors.white),
                        ),
                      ),
                      vspace(height: 10),
                      appText(
                        text: _app.username.value,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      vspace(height: 5),
                      appText(text: _app.userEmail.value, fontSize: 13),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: ListTile(
                  leading: Icon(Icons.home, color: primaryColor),
                  title:
                      appText(text: 'Home', fontSize: 12, color: Colors.black),
                  onTap: () {
                    Navigator.pop(context);
                    Get.offAllNamed('/homePage');
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: ListTile(
                    leading: Image.asset('assets/images/icon_donate.png'),
                    title: appText(
                        text: 'Giving History',
                        fontSize: 12,
                        color: Colors.black),
                    onTap: () {
                      Navigator.pop(context);
                      Get.toNamed('/givingHistory',
                          arguments: color,
                          parameters: {
                            'app_mode': appMode,
                            'app': app,
                          });
                    }),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: ListTile(
                  leading: Icon(
                    Icons.share,
                    color: primaryColor,
                  ),
                  title:
                      appText(text: 'Share', fontSize: 12, color: Colors.black),
                  onTap: () {
                    Share.share(
                        'The act of donating is the act that stays with a person forever in their life in this world and after death too.\nI have found an perfect application for you to share your donations to the right ones.\nGet it now and give it a try.',
                        subject: 'Share Love Easy Giving!');
                    Navigator.pop(context);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: ListTile(
                  leading: Icon(
                    Icons.mail,
                    color: primaryColor,
                  ),
                  title: appText(
                      text: 'Contact Us', fontSize: 12, color: Colors.black),
                  onTap: () {
                    launch('mailto: loveeasygiving@gmail.com');
                    Navigator.pop(context);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: ListTile(
                  leading: Icon(Icons.power_settings_new, color: primaryColor),
                  title: appText(
                      text: 'Log Out', fontSize: 12, color: Colors.black),
                  onTap: () {
                    _app.userLogout();
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 10,
            left: 70,
            child: Center(child: copyrightwidget(color: primaryColor)),
          ),
        ],
      ),
    );
  }
}
