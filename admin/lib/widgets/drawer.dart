import '../../Constants/colors.dart';
import '../../Controller/app_controller.dart';
import '../../widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  final MyAppController _app = Get.find();
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 45,
                backgroundImage: NetworkImage(_app.picture.value),
              ),
              const SizedBox(height: 15),
              TextWidget(
                text: _app.adminName.value,
                alignment: Alignment.center,
                weight: FontWeight.bold,
              ),
            ],
          )),
          ListTile(
            leading: const Icon(
              Icons.home_outlined,
              color: primaryDark,
            ),
            title: const TextWidget(
              text: 'Home',
            ),
            onTap: () => Get.offAllNamed('/home'),
          ),
          ListTile(
            leading: const Icon(
              Icons.logout_outlined,
              color: primaryDark,
            ),
            title: const TextWidget(
              text: 'Logout',
            ),
            onTap: () => _app.logout(),
          ),
        ],
      ),
    );
  }
}

class DrawerTile extends StatelessWidget {
  const DrawerTile(
      {Key? key,
      required this.text,
      required this.icon,
      required this.onPressed})
      : super(key: key);
  final String text;
  // ignore: prefer_typing_uninitialized_variables
  final icon;
  final Function onPressed;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: primaryDark),
      title: TextWidget(
        text: text,
      ),
      onTap: () {},
    );
  }
}
