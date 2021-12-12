import 'dart:ui';
import '../../Constants/colors.dart';
import '../../Controller/app_controller.dart';
import '../../styles/button_styles.dart';
import '../../widgets/alert_widgets.dart';
import '../../widgets/app_drawer.dart';
import '../../widgets/copyright.dart';
import '../../widgets/custom_spacer.dart';
import '../../widgets/ramadan_home_top.dart';
import '../../widgets/steam_builder.dart';
import '../../widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RamadanHome extends StatefulWidget {
  const RamadanHome({Key key}) : super(key: key);

  @override
  _RamadanHomeState createState() => _RamadanHomeState();
}

class _RamadanHomeState extends State<RamadanHome> {
  final MyAppController _appController = Get.find();
  Color _background = Get.arguments;
  var _parameters = Get.parameters;
  String name, address, price, stripeKey;
  int isSelected;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _background,
      persistentFooterButtons: [copyrightwidget()],
      drawer: AppDrawer(
        color: _background,
        appMode: _parameters['app_mode'],
        app: _parameters['app'],
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [
            vspace(height: 50),
            Align(
              alignment: Alignment.topLeft,
              child: Builder(
                builder: (context) => IconButton(
                  icon: Image.asset('assets/images/Group 215.png',
                      width: 25.23, height: 15.44),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                ),
              ),
            ),
            vspace(height: 20),
            ramadanHomeTop(
                title: _parameters['title'].toUpperCase(),
                subtitle: _parameters['subtitle']),
            StreamBuilder(
              stream: _appController.charRef.snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return builderCommons(background: _background);
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return builderCommons(background: _background);
                }
                return GridView.builder(
                    padding: EdgeInsets.all(10),
                    shrinkWrap: true,
                    itemCount: snapshot.data.docs.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 13.0,
                        mainAxisSpacing: 13.0),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            if (isSelected == null) {
                              isSelected = index;
                              name = snapshot.data.docs[index].get('cName');
                              address =
                                  snapshot.data.docs[index].get('Address');
                              stripeKey =
                                  snapshot.data.docs[index].get('StripeApiKey');
                            } else if (isSelected == index) {
                              isSelected = null;
                              name = null;
                              address = null;
                              stripeKey = null;
                            }
                          });
                        },
                        child: Container(
                          height: 100,
                          width: 102,
                          padding: EdgeInsets.only(
                              left: 7, right: 7, top: 5, bottom: 5),
                          decoration: BoxDecoration(
                            color: isSelected != index
                                ? index == 0 || index == 6 || index == 8
                                    ? primaryColor
                                    : Colors.black.withOpacity(0.1)
                                : selectColor,
                            border: Border.all(color: selectColor),
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              colorFilter: ColorFilter.mode(
                                  isSelected != index
                                      ? index == 0 || index == 6 || index == 8
                                          ? primaryColor
                                          : Colors.black.withOpacity(0.1)
                                      : selectColor,
                                  BlendMode.color),
                              image: NetworkImage(
                                  snapshot.data.docs[index].get('rimage')),
                            ),
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 17.0),
                                child: appText(
                                  text: snapshot.data.docs[index]
                                      .get('cName')
                                      .toString()
                                      .split(' ')[0],
                                  fontSize: 12,
                                  align: TextAlign.center,
                                  alignment: Alignment.center,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              appText(
                                text: snapshot.data.docs[index]
                                    .get('cName')
                                    .toString()
                                    .split(' ')[1],
                                fontSize: 12,
                                align: TextAlign.center,
                                alignment: Alignment.center,
                                fontWeight: FontWeight.w500,
                              ),
                              appText(
                                text: snapshot.data.docs[index]
                                    .get('cName')
                                    .toString()
                                    .split(' ')[2],
                                fontSize: 12,
                                align: TextAlign.center,
                                alignment: Alignment.center,
                                fontWeight: FontWeight.w500,
                              ),
                            ],
                          ),
                        ),
                      );
                    });
              },
            ),
            vspace(height: 20),
            Container(
              width: 130,
              height: 41,
              child: OutlinedButton(
                child: appText(
                    text: 'NEXT',
                    fontSize: 14,
                    color: textColor,
                    fontWeight: FontWeight.bold,
                    alignment: Alignment.center,
                    align: TextAlign.center),
                onPressed: () {
                  if (name != null && address != null && stripeKey != null) {
                    Get.toNamed(
                      '/Rcause',
                      arguments: _background,
                      parameters: {
                        'title': 'CHOOSE YOUR CAUSE',
                        'subtitle': _parameters['subtitle'],
                        'app_mode': _parameters['app_mode'],
                        'task_mode': 'Cause',
                        'charity_name': name,
                        'charity_address': address,
                        'stripe_key': stripeKey,
                        'app': _parameters['app'],
                      },
                    );
                  } else {
                    showSnackbar(
                      title: 'Attention!',
                      message: "Please select a charity to proceed.",
                    );
                  }
                },
                style: outlinebutton(
                  borderColor: selectColor,
                  borderwidth: 1.5,
                  radius: 10,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
