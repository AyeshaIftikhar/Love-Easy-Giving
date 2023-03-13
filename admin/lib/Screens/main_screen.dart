import '../../Controller/app_controller.dart';
import '../../Screens/home_screen.dart';
import '../../Screens/Auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final MyAppController _controller = Get.find();
  @override
  void initState() {
    _controller.checkUserLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return 
    Obx(() => _controller.isUserLogin.value
        ? const HomeScreen()
        : const LoginScreen()
    )
    ;
  }
}
