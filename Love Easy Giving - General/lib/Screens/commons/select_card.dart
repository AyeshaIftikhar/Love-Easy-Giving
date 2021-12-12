import 'package:leggenerral/widgets/copyright.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Controller/app_controller.dart';
import '../../Constants/colors.dart';
import '../../styles/button_styles.dart';
import '../../widgets/alert_widgets.dart';
import '../../widgets/steam_builder.dart';
import '../../widgets/const_widgets.dart';
import '../../widgets/custom_spacer.dart';
import '../../widgets/text_widget.dart';

class SelectCard extends StatefulWidget {
  @override
  _SelectCardState createState() => _SelectCardState();
}

class _SelectCardState extends State<SelectCard> {
  final MyAppController _controller = Get.find();
  Color backgroundColor = Get.arguments;
  var parameters = Get.parameters;
  String number = '';
  String expiry = '';
  String name = '';
  int selected;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      persistentFooterButtons: [
        copyrightwidget(
          color: backgroundColor == Colors.white ? selectColor : Colors.white,
        ),
      ],
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: [
              vspace(height: 50),
              customTop(
                color: selectColor,
                text: 'SELECT CARD',
                fontSize: 17,
                fontWeight: FontWeight.bold,
                textColor: backgroundColor == Colors.white
                    ? selectColor
                    : Colors.white,
              ),
              vspace(height: 10),
              Column(
                children: [
                  StreamBuilder(
                      stream: _controller.cardRef
                          .where('userid', isEqualTo: _controller.userid.value)
                          .where('appmode', isEqualTo: parameters['app'])
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return builderCommons(background: backgroundColor);
                        }
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return builderCommons(background: backgroundColor);
                        }
                        return ListView.builder(
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            itemCount: snapshot.data.docs.length,
                            itemBuilder: (context, index) {
                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ListTile(
                                    title: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        appText(
                                          text: snapshot.data.docs[index]
                                              .get('card_number'),
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: backgroundColor == Colors.white
                                              ? htextDark
                                              : Colors.white,
                                        ),
                                        appText(
                                          text: snapshot.data.docs[index]
                                              .get('expiry_date'),
                                          fontSize: 17,
                                          color: backgroundColor == Colors.white
                                              ? htextDark
                                              : Colors.white,
                                        ),
                                      ],
                                    ),
                                    subtitle: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        appText(
                                          text: snapshot.data.docs[index]
                                              .get('holder_name'),
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: backgroundColor == Colors.white
                                              ? htextDark
                                              : Colors.white,
                                        ),
                                        selected == index
                                            ? IconButton(
                                                onPressed: () {},
                                                icon:
                                                    Icon(Icons.arrow_back_ios),
                                                iconSize: 20,
                                                alignment:
                                                    Alignment.centerRight,
                                                color: selectColor)
                                            : Container(),
                                      ],
                                    ),
                                    onTap: () {
                                      setState(() {
                                        if (selected == index) {
                                          selected = null;
                                          name = null;
                                          number = null;
                                          expiry = null;
                                          print(name);
                                          print(number);
                                          print(expiry);
                                        } else {
                                          print('index' + index.toString());
                                          selected = index;
                                          print(
                                              'selected' + selected.toString());
                                          name = snapshot.data.docs[index]
                                              .get('holder_name');
                                          number = snapshot.data.docs[index]
                                              .get('card_number');
                                          expiry = snapshot.data.docs[index]
                                              .get('expiry_date');
                                          print(name);
                                          print(number);
                                          print(expiry);
                                        }
                                      });
                                    },
                                  ),
                                  Divider(
                                    thickness: 2,
                                    color: backgroundColor == scaffoldColor
                                        ? Colors.white
                                        : selectColor,
                                  ),
                                  vspace(height: 20),
                                ],
                              );
                            });
                      }),
                  vspace(height: 50),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 130,
                        height: 41,
                        child: OutlinedButton(
                          onPressed: () {
                            if (name != null &&
                                number != null &&
                                expiry != null) {
                              _controller.cardNumber.value = number;
                              _controller.holderName.value = name;
                              _controller.expiry.value = expiry;
                              Get.toNamed(
                                '/pay',
                                arguments: backgroundColor,
                                parameters: {
                                  'pay_type': parameters['pay_type'],
                                  'merchant_id': parameters['stripeKey'],
                                  'm_address': parameters['address'],
                                  'mosque_name': parameters['m_name'],
                                  'amount': parameters['amount'],
                                  'app_mode': parameters['app_mode'],
                                  'charity_cause': parameters['charity_cause'],
                                  'app': parameters['app'],
                                  'unicode': parameters['unicode'],
                                  'stripeKey': parameters['stripekey'],
                                },
                              );
                            } else {
                              showToast(
                                  message:
                                      'Please select a card to proceed further.');
                            }
                          },
                          child: appText(
                              text: 'PAY NOW',
                              fontSize: 13,
                              color: backgroundColor == Colors.white
                                  ? htextDark
                                  : Colors.white,
                              alignment: Alignment.center,
                              fontWeight: FontWeight.bold,
                              align: TextAlign.center),
                          style: outlinebutton(
                            radius: 10,
                            borderwidth: 1.5,
                            borderColor: backgroundColor == scaffoldColor
                                ? Colors.white
                                : htextDark,
                          ),
                        ),
                      ),
                      Container(
                        width: 130,
                        height: 41,
                        child: OutlinedButton(
                          onPressed: () => Get.toNamed('/addCard',
                              arguments: backgroundColor,
                              parameters: {
                                'merchant_id': parameters['stripeKey'],
                                'app': parameters['app'],
                              }),
                          child: appText(
                              text: 'ADD CARD',
                              fontSize: 13,
                              color: backgroundColor == Colors.white
                                  ? htextDark
                                  : Colors.white,
                              alignment: Alignment.center,
                              fontWeight: FontWeight.bold,
                              align: TextAlign.center),
                          style: outlinebutton(
                            radius: 10,
                            borderwidth: 1.5,
                            primary: primaryColor,
                            borderColor: backgroundColor == scaffoldColor
                                ? Colors.white
                                : htextDark,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
