import 'package:flutter/material.dart';
import 'package:get/get.dart';
import './Constants/app_routes.dart';
import './Controller/app_controller.dart';
import './styles/button_styles.dart';
import './styles/input_decoration.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // ignore: unused_field
  final MyAppController _controller = Get.put(MyAppController());

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: '/',
      getPages: appPages,
      title: 'Love Easy Giving',
      theme: ThemeData(
        appBarTheme: appbar(),
        accentColor: Color(0xffB08850),
        primaryColor: Color(0xffB08850),
        inputDecorationTheme: inputDecoration(),
        floatingActionButtonTheme: floatingButton(),
        iconTheme: IconThemeData(color: Colors.white),
        primaryIconTheme: IconThemeData(color: Color(0xffB08850)),
        textButtonTheme: TextButtonThemeData(
          style: textButton(),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(style: outlinebutton()),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: elevatedButton(),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
