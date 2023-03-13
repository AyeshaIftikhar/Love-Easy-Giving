import '../../Constants/colors.dart';
import '../../Controller/app_controller.dart';
import '../../Screens/Hajj/hajj_charities.dart';
import '../../Screens/Hajj/qurbani.dart';
import '../../widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class LoveHajj extends StatelessWidget {
  LoveHajj({Key? key}) : super(key: key);
  // ignore: unused_field
  final MyAppController _app = Get.find<MyAppController>();
  // ignore: prefer_typing_uninitialized_variables
  var defaultTabController;
  List<Tab> tabs = const [
    Tab(text: 'QURBANI'),
    Tab(text: 'CHARITIES'),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          centerTitle: true,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white.withAlpha(0),
          title: const TextWidget(
            text: 'Love Hajj',
            weight: FontWeight.bold,
            alignment: Alignment.center,
          ),
          leading: IconButton(
            onPressed: () => Get.offAllNamed('/'),
            icon: const Icon(Icons.arrow_back_ios, color: htextDark),
          ),
        ),
        body: Column(
          children: [
            const SizedBox(height: 50),
            Center(
              child: Container(
                width: Get.width * .5,
                height: 33,
                margin: const EdgeInsets.only(left: 20, right: 25),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: const Color(0xff59442A)),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: TabBar(
                  tabs: tabs,
                  // isScrollable: true,
                  controller: defaultTabController,
                  indicator: BoxDecoration(
                    color: primaryDark,
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  labelColor: Colors.white,
                  unselectedLabelColor: const Color(0xff6B5233),
                  labelStyle: const TextStyle(fontFamily: 'Futura'),
                  unselectedLabelStyle: const TextStyle(fontFamily: 'Futura'),
                ),
              ),
            ),
            Expanded(child: TabBarView(children: [
              Qurbani(),
              HajjCharity(),
            ])),
          ],
        ),
      ),
    );
  }
}
