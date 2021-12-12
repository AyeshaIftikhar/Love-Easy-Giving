import 'dart:ui';
import '../../Constants/colors.dart';
import '../../Controller/app_controller.dart';
import '../../styles/button_styles.dart';
import '../../widgets/alert_widgets.dart';
import '../../widgets/const_widgets.dart';
import '../../widgets/copyright.dart';
import '../../widgets/custom_spacer.dart';
import '../../widgets/steam_builder.dart';
import '../../widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CauseScreen extends StatefulWidget {
  const CauseScreen({Key key}) : super(key: key);
  @override
  _CauseScreenState createState() => _CauseScreenState();
}

class _CauseScreenState extends State<CauseScreen> {
  final MyAppController _appController = Get.find();
  Color _background = Get.arguments;
  var _parameters = Get.parameters;
  String cause, price, image,name, stripeKey;
  int isSelected;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _background,
      persistentFooterButtons: [copyrightwidget()],
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [
            vspace(height: 50),
            customTop(
                color: selectColor,
                text: _parameters['title'],
                fontSize: 28,
                textColor: textColor,
                fontWeight: FontWeight.bold,
                align: TextAlign.center,
                alignment: Alignment.center),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: appText(
                text: _parameters['subtitle'],
                fontSize: 17,
                color: subtitleColor,
                align: TextAlign.center,
                alignment: Alignment.center,
              ),
            ),
            vspace(height: 10),
            StreamBuilder(
              stream: _appController.causesRef.snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return builderCommons(background: _background);
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return builderCommons(background: _background);
                }
                return GridView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data.docs.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 13.0,
                        mainAxisSpacing: 13.0),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          try {
                            setState(() {
                              stripeKey = _parameters['stripe_key'];
                            });
                            _appController.cbasketRef.add({
                              'userid': _appController.userid.value,
                              'Time': DateTime.now(),
                              'paid': 'no',
                              'quantity': 1,
                              'unicode': '0x00A3',
                              'stripekey': _parameters['stripe_key'],
                              'appmode': _parameters['app'],
                              'charity': _parameters['charity_name'],
                              'charity_address': _parameters['charity_address'],
                              'cause_name':
                                  snapshot.data.docs[index].get('name'),
                              'type': snapshot.data.docs[index].get('type'),
                              'price': snapshot.data.docs[index].get('price'),
                              'initial_price': int.parse(
                                  snapshot.data.docs[index].get('price')),
                            }).then((value) {
                              showToast(
                                  message:
                                      'Item added to cart successfully.\nClick on NEXT to proceed further.');
                            });
                          } catch (e) {
                            print('Cause Exception: $e');
                          }
                        },
                        child: Container(
                          height:101,
                          width: 102,
                          decoration: BoxDecoration(
                            color: isSelected != index
                                ? index == 0 || index == 11
                                    ? primaryColor
                                    : Colors.black.withOpacity(0.3)
                                : selectColor,
                            border: Border.all(color: selectColor),
                            borderRadius: BorderRadius.circular(7),
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              colorFilter: ColorFilter.mode(
                                  isSelected != index
                                      ? index == 0 || index == 11
                                          ? primaryColor
                                          : Colors.black.withOpacity(0.3)
                                      : selectColor,
                                  BlendMode.darken),
                              image: NetworkImage(
                                snapshot.data.docs[index].get('image'),
                              ),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              appText(
                                text: '\u00A3' +
                                    '' +
                                    snapshot.data.docs[index].get('price'),
                                fontSize: 12,
                                align: TextAlign.center,
                                alignment: Alignment.center,
                              ),
                              appText(
                                text: snapshot.data.docs[index].get('name'),
                                fontSize: 12,
                                align: TextAlign.center,
                                alignment: Alignment.center,
                              ),
                            ],
                          ),
                        ),
                      );
                    });
              },
            ),
            vspace(height: 30),
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
                  Get.toNamed(
                    '/Rbasket',
                    arguments: _background,
                    parameters: {
                      'title': 'YOUR RAMADAN BASKET',
                      'app_mode': _parameters['app_mode'],
                      'app': _parameters['app'],
                      'unicode': '0x00A3',
                      'stripeKey': _parameters['stripe_key'],
                    },
                  );
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
