import '../../Constants/colors.dart';
import '../../Controller/app_controller.dart';
import '../../Screens/History/history.dart';
import '../../widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class DonationHistory extends StatelessWidget {
  DonationHistory({Key? key}) : super(key: key);
  final MyAppController _app = Get.find<MyAppController>();
  final _parameters = Get.parameters;
  var _tabController;
  List<Tab> tabs = const [
    Tab(text: 'Love Jummah'),
    Tab(text: 'Love Ramadan'),
    Tab(text: 'Love Hajj'),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          centerTitle: true,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white.withAlpha(0),
          title: const TextWidget(
            text: 'Donation History',
            weight: FontWeight.bold,
            alignment: Alignment.center,
          ),
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(Icons.arrow_back_ios, color: htextDark),
          ),
        ),
        body: Column(
          children: [
            const SizedBox(height: 30),
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
                  controller: _tabController,
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
              History(appType: 'Jummah', appMode: _parameters['app_mode']!),
              History(appType: 'Ramadan', appMode: _parameters['app_mode']!),
              History(appType: 'Hajj', appMode: _parameters['app_mode']!),
            ])),
          ],
        ),
      ),
    );
  }
}
