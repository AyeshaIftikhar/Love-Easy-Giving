import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Constants/colors.dart';
import '../styles/button_styles.dart';
import './custom_spacer.dart';
import './text_widget.dart';

mosqueDialog(
  BuildContext context, {
  @required String name,
  @required String logo,
  @required String buttonText,
  @required String address,
  @required String stripeKey,
  @required String bottomText,
  @required String footerText,
  @required String app,
  Color backgroundColor = Colors.white,
}) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          elevation: 5.0,
          insetPadding: EdgeInsets.all(0),
          contentPadding: EdgeInsets.all(0),
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(17),
          ),
          title: IconButton(
            tooltip: 'Exit',
            onPressed: () => Get.back(),
            alignment: Alignment.centerLeft,
            icon: Icon(
              Icons.arrow_back_ios,
              color: selectColor,
            ),
          ),
          content: Container(
            margin: EdgeInsets.only(top: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                vspace(height: 10),
                Container(
                  height: 100,
                  child: Image.network(logo),
                ),
                vspace(height: 30),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20),
                  child: appText(
                    text: name,
                    fontSize: 18,
                    color: backgroundColor == Colors.white
                        ? htextColor
                        : Colors.white,
                    alignment: Alignment.center,
                    align: TextAlign.center,
                  ),
                ),
                vspace(height: 15),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20),
                  child: appText(
                    text: address,
                    fontSize: 15,
                    color: backgroundColor == Colors.white
                        ? htextColor
                        : Colors.white,
                    alignment: Alignment.center,
                    align: TextAlign.center,
                  ),
                ),
                vspace(height: 35),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 125,
                        height: 41,
                        child: OutlinedButton(
                          onPressed: () {
                            Get.toNamed('/selectCard',
                                arguments: backgroundColor,
                                parameters: {
                                  'm_name': name,
                                  'address': address,
                                  'stripeKey': stripeKey,
                                  'pay_type': 'Pay-One-Off',
                                  'amount': '',
                                  'app_mode': '',
                                  'charity_cause': '',
                                  'cause_name': '',
                                  'app': app,
                                });
                          },
                          child: appText(
                              text: 'PAY ONE-OFF',
                              fontSize: 12,
                              color: backgroundColor == Colors.white
                                  ? htextColor
                                  : Colors.white,
                              fontWeight: FontWeight.bold,
                              alignment:Alignment.center,
                              align: TextAlign.center),
                          style: outlinebutton(
                            radius: 10,
                            primary: selectColor,
                            borderColor: backgroundColor == scaffoldColor
                                ? Colors.white
                                : selectColor,
                          ),
                        ),
                      ),
                      Container(
                        // width: 155,
                        height: 41,
                        child: OutlinedButton(
                          onPressed: () {
                            Get.toNamed('/selectCard',
                                arguments: backgroundColor,
                                parameters: {
                                  'm_name': name,
                                  'address': address,
                                  'stripeKey': stripeKey,
                                  'pay_type': 'Schdeule',
                                  'amount': '',
                                  'app_mode': '',
                                  'charity_cause': '',
                                  'cause_name': '',
                                  'app': app,
                                });
                          },
                          child: appText(
                              text: buttonText,
                              fontSize: 12,
                              alignment:Alignment.center,
                              color: backgroundColor == Colors.white
                                  ? htextColor
                                  : Colors.white,
                              fontWeight: FontWeight.bold,
                              align: TextAlign.center),
                          style: outlinebutton(
                            radius: 10,
                            primary: selectColor,
                            borderColor: backgroundColor == scaffoldColor
                                ? Colors.white
                                : selectColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                vspace(height: 50),
                if (bottomText != '')
                  appText(
                      text: bottomText,
                      fontSize: 12,
                      color: backgroundColor == Colors.white
                          ? htextColor
                          : Colors.white,
                      alignment: Alignment.center,
                      align: TextAlign.center),
                if (footerText != '')
                  appText(
                    text: footerText,
                    fontSize: 12,
                    color: backgroundColor == Colors.white
                        ? htextColor
                        : Colors.white,
                    fontWeight: FontWeight.bold,
                    alignment: Alignment.center,
                    align: TextAlign.center,
                  ),
                if (bottomText != '' || footerText != '') vspace(height: 50),
              ],
            ),
          ),
        );
      });
}

/// hajj dialog
hajjDialog(
  BuildContext context, {
  @required String mode,
  @required String stripeKey,
  @required String name,
  @required String address,
  @required String bottomText,
  @required String logo,
  @required String app,
  String amount,
  Color backgroundColor = Colors.white,
}) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          elevation: 5.0,
          insetPadding: EdgeInsets.all(0),
          contentPadding: EdgeInsets.all(0),
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(17),
          ),
          title: IconButton(
            tooltip: 'Exit',
            onPressed: () => Get.back(),
            alignment: Alignment.centerLeft,
            icon: Icon(
              Icons.arrow_back_ios,
              color: selectColor,
            ),
          ),
          content: Container(
            margin: EdgeInsets.only(top: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 75,
                  child: Image.network(logo),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20.0, right: 20, top: 25),
                  child: appText(
                    text: name,
                    fontSize: 15,
                    color: htextDark,
                    alignment: Alignment.center,
                    align: TextAlign.center,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                vspace(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20),
                  child: appText(
                    text: address,
                    fontSize: 15,
                    color: htextDark,
                    alignment: Alignment.center,
                    align: TextAlign.center,
                  ),
                ),
                vspace(height: 25),
                if (mode == 'qurbani')
                  Center(
                    child: Container(
                      width: 200,
                      height: 50,
                      child: OutlinedButton(
                        onPressed: () {
                          print(amount);
                          Get.toNamed('/selectCard',
                              arguments: backgroundColor,
                              parameters: {
                                'm_name': name,
                                'address': address,
                                'pay_type': 'Pay-One-Off',
                                'stripeKey': stripeKey,
                                'amount': amount,
                                'app_mode': 'Hajj_Qurbani',
                                'charity_cause': '',
                                'cause_name': '',
                                'app': app,
                              });
                        },
                        child: appText(
                            text: 'PAY ONE-OFF',
                            fontSize: 12,
                            color: backgroundColor == Colors.white
                                ? htextDark
                                : Colors.white,
                            alignment: Alignment.center,
                            fontWeight: FontWeight.bold,
                            align: TextAlign.center),
                        style: outlinebutton(
                          radius: 10,
                          primary: selectColor,
                          borderColor: selectColor,
                          borderwidth:2,
                        ),
                      ),
                    ),
                  ),
                if (mode == 'charity')
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 45,
                          child: OutlinedButton(
                            onPressed: () {
                              Get.toNamed('/selectCard',
                                  arguments: backgroundColor,
                                  parameters: {
                                    'm_name': name,
                                    'address': address,
                                    'pay_type': 'Pay-One-Off',
                                    'stripeKey': stripeKey,
                                    'amount': amount,
                                    'app_mode': 'Hajj_Sadqah',
                                    'charity_cause': '',
                                    'cause_name': '',
                                    'app': app,
                                  });
                            },
                            child: appText(
                                text: 'PAY ONE-OFF',
                                fontSize: 12,
                                color: backgroundColor == Colors.white
                                    ? htextDark
                                    : Colors.white,
                                    alignment:Alignment.center,
                                fontWeight: FontWeight.bold,
                                align: TextAlign.center),
                            style: outlinebutton(
                              radius: 10,
                              primary: selectColor,
                              borderColor: selectColor,
                              borderwidth: 2,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Container(
                            height: 45,
                            child: OutlinedButton(
                              onPressed: () {
                                Get.toNamed('/selectCard',
                                    arguments: backgroundColor,
                                    parameters: {
                                      'm_name': name,
                                      'address': address,
                                      'pay_type': 'Schdeule',
                                      'stripeKey': stripeKey,
                                      'amount': amount,
                                      'app_mode': 'Hajj_Sadqah',
                                      'charity_cause': '',
                                      'cause_name': '',
                                      'app': app,
                                    });
                              },
                              child: appText(
                                  text: 'SCHEDULE SADQAH',
                                  fontSize: 12,
                                  color: backgroundColor == Colors.white
                                      ? htextDark
                                      : Colors.white,
                                      alignment:Alignment.center,
                                  fontWeight: FontWeight.bold,
                                  align: TextAlign.center),
                              style: outlinebutton(
                                radius: 10,
                                primary: selectColor,
                                borderColor: selectColor,
                                borderwidth: 2,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                vspace(height: 30),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: appText(
                    text: bottomText,
                    fontSize: 13,
                    color: backgroundColor == Colors.white
                        ? htextDark
                        : Colors.white,
                    alignment: Alignment.center,
                    align: TextAlign.center,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                vspace(height: 30),
              ],
            ),
          ),
        );
      });
}
