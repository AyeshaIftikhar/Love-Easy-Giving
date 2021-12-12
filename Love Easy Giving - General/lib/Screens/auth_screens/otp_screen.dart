import 'package:leggenerral/widgets/copyright.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'package:flutter/gestures.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../Controller/app_controller.dart';
import '../../Constants/colors.dart';
import '../../styles/button_styles.dart';
import '../../widgets/alert_widgets.dart';
import '../../widgets/custom_spacer.dart';
import '../../widgets/screen_decor.dart';

// ignore: must_be_immutable
class OtpScreen extends StatefulWidget {
  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final MyAppController _app = Get.find();
  String phone = Get.arguments;
  var otp = GlobalKey<FormState>();
  TextEditingController textEditingController = TextEditingController();
  // ignore: close_sinks
  StreamController<ErrorAnimationType> errorController;
  bool hasError = false;
  String currentText = "";
  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    _app.phoneNumberVerification(phoneNo: phone, isCodeSent: true);
    super.initState();
  }

  @override
  void dispose() {
    errorController.close();
    // textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(phone);
    return Scaffold(
      backgroundColor: scaffoldColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            topDecor(
              width: 321,
              height: 160.5,
            ),
            Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
              backgroundColor: Colors.transparent,
              insetPadding: EdgeInsets.all(0),
              child: Stack(
                children: [
                  Container(
                    width: Get.width,
                    margin: EdgeInsets.only(top: 40),
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black,
                            offset: Offset(0, 10),
                            blurRadius: 10),
                      ],
                    ),
                    child: Form(
                      key: otp,
                      child: Column(
                        children: [
                          vspace(height: 40),
                          Padding(
                            padding: EdgeInsets.only(
                                top: 60, left: 20, right: 20, bottom: 5),
                            child: Text(
                              'VERIFY YOUR IDENTITY',
                              style: TextStyle(
                                  fontFamily: 'Futura',
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Text(
                            'We have send a code $phone',
                            style: TextStyle(fontFamily: 'Futura'),
                          ),
                          vspace(height: 70),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 60.0, right: 60),
                            child: PinCodeTextField(
                              length: 6,
                              enabled: true,
                              appContext: context,
                              enableActiveFill: true,
                              enablePinAutofill: true,
                              cursorColor: primaryColor,
                              animationType: AnimationType.fade,
                              controller: textEditingController,
                              keyboardType: TextInputType.number,
                              errorAnimationController: errorController,
                              animationDuration: Duration(milliseconds: 300),
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              onCompleted: (v) {
                                print("Completed");
                              },
                              onSubmitted: (pin) {
                                print("Submitted");
                                if (pin.length == 6) {
                                  _app.onFormSubmitted(
                                      number: textEditingController.text);
                                } else {
                                  showToast(
                                    message: "Invalid OTP",
                                  );
                                }
                              },
                              beforeTextPaste: (text) {
                                print("Allowing to paste $text");
                                return true;
                              },
                              textStyle: TextStyle(
                                fontFamily: 'Futura',
                                color: Colors.white,
                              ),
                              pastedTextStyle: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                              onChanged: (val) {
                                print(val);
                                setState(() {
                                  currentText = val;
                                });
                              },
                              boxShadows: [
                                BoxShadow(
                                  offset: Offset(0, 1),
                                  color: Colors.black12,
                                  blurRadius: 10,
                                )
                              ],
                              validator: (v) {
                                if (v.isEmpty) {
                                  return '*Required';
                                }
                                if (v.length < 3) {
                                  return "I'm from validator";
                                } else {
                                  return null;
                                }
                              },
                              pinTheme: PinTheme(
                                fieldWidth: 40,
                                fieldHeight: 50,
                                shape: PinCodeFieldShape.box,
                                borderRadius: BorderRadius.circular(5),
                                inactiveColor: Colors.grey.withOpacity(0.5),
                                activeFillColor: Colors.grey.withOpacity(0.5),
                                inactiveFillColor:
                                    Colors.white.withOpacity(0.5),
                                selectedColor: Colors.white,
                                selectedFillColor: Colors.white,
                              ),
                            ),
                          ),
                          vspace(height: 20),
                          InkWell(
                            child: Text(
                              'Resend code',
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontFamily: 'Futura',
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                            onTap: () {
                              _app.phoneNumberVerification(
                                  phoneNo: phone, isCodeSent: true);
                            },
                          ),
                          vspace(height: 40),
                          Container(
                            width: 235,
                            height: 50,
                            child: OutlinedButton(
                              child: Text("NEXT",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: 'Futura',
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                              onPressed: () {
                                if (otp.currentState.validate()) {
                                  print('clicked');
                                  print(textEditingController.text);
                                  _app.checkPrivacyPolicyStatus();
                                  if (_app.privacyAccepted.value) {
                                    if (textEditingController.text.length ==
                                        6) {
                                      _app.onFormSubmitted(
                                          number: textEditingController.text);
                                    } else {
                                      showToast(message: "Invalid OTP");
                                    }
                                  } else {
                                    showToast(
                                      message:
                                          'You need to accept the privacy policy and Terms and Conditions first.',
                                    );
                                  }
                                  otp.currentState.save();
                                }
                              },
                              style: outlinebutton(
                                surface: Colors.grey.withOpacity(0.5),
                                primary: primaryColor,
                                borderColor: primaryColor,
                              ),
                            ),
                          ),
                          vspace(height: 30),
                          InkWell(
                            child: Text(
                              'By signing up, you agree to our Ts & Cs',
                              style: TextStyle(
                                fontFamily: 'Futura',
                                fontSize: 12,
                                decoration: TextDecoration.underline,
                                height: 2,
                              ),
                            ),
                            onTap: () {
                              Get.toNamed('/privacyPolicy');
                            },
                          ),
                          vspace(height: 40),
                          copyrightwidget(color: primaryColor),
                           vspace(height: 20),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 20,
                    right: 20,
                    child: CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.white,
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(40)),
                        child: Container(
                          color: primaryColor,
                          child: Image.asset('assets/images/pic.png'),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
