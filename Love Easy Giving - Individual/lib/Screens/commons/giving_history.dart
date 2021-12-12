import '../../widgets/copyright.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Controller/app_controller.dart';
import '../../Constants/colors.dart';
import '../../widgets/const_widgets.dart';
import '../../widgets/custom_spacer.dart';
import './paid_history.dart';
import './scheduled_history.dart';

class GivingHistory extends StatefulWidget {
  @override
  _GivingHistoryState createState() => _GivingHistoryState();
}

class _GivingHistoryState extends State<GivingHistory> {
  final MyAppController _controller = Get.find();
  Color backgroundColor = Get.arguments;
  var _parameters = Get.parameters;
  TabController _tabController;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("Giving history:" + _controller.userid.value);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: Padding(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: [
              vspace(height: 55),
              customTop(
                  color: selectColor,
                  text: 'YOUR GIVING HISTORY',
                  textColor: backgroundColor == Colors.white
                      ? htextDark
                      : Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  align: TextAlign.center,
                  alignment: Alignment.center),
              vspace(height: 20),
              Container(
                height: 33,
                margin: EdgeInsets.only(left: 20, right: 25),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: backgroundColor == loveJummahScaffold
                        ? Colors.white
                        : Color(0xff59442A),
                  ),
                  borderRadius: BorderRadius.circular(
                    5.0,
                  ),
                ),
                child: TabBar(
                  controller: _tabController,
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      5.0,
                    ),
                    color: primaryColor,
                  ),
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.black,
                  labelStyle: TextStyle(fontFamily: 'Futura'),
                  unselectedLabelStyle: TextStyle(fontFamily: 'Futura'),
                  tabs: [
                    Tab(
                      text: 'PAID',
                    ),
                    Tab(
                      text: 'SCHEDULED',
                    ),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(children: [
                  PaidHistory(
                    backgroundColor: backgroundColor,
                    userid: _controller.userid.value,
                    appmode: _parameters['app_mode'],
                    app: _parameters['app'],
                  ),
                  ScheduledHistory(
                    backgroundColor: backgroundColor,
                    userid: _controller.userid.value,
                    appmode: _parameters['app_mode'],
                    app: _parameters['app'],
                  ),
                ]),
              ),

              ///

              copyrightwidget(
                color: backgroundColor == Colors.white
                    ? selectColor
                    : Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
