import '../../Controller/app_controller.dart';
import '../../styles/button_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Constants/app_routes.dart';

class MyApp extends StatelessWidget {
  MyApp({ Key? key }) : super(key: key);
  // ignore: unused_field
  final MyAppController _controller = Get.put(MyAppController());

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: '/',
      getPages: appPages,
      themeMode: ThemeMode.light,
      title: 'Love Easy Giving',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: appbar(),
        // ignore: deprecated_member_use
        accentColor: const Color(0xffB08850),
        primaryColor: const Color(0xffB08850),
        // inputDecorationTheme: inputDecoration(),
        floatingActionButtonTheme: floatingButton(),
        iconTheme:const IconThemeData(color: Colors.white),
        primaryIconTheme: const IconThemeData(color: Color(0xffB08850)),
        textButtonTheme: TextButtonThemeData(
          style: textButton(),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(style: outlinebutton()),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: elevatedButton(),
        ),
      ),
    );
  }
}