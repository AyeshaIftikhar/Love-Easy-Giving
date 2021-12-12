import '../../widgets/copyright.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Controller/app_controller.dart';
import '../../Constants/colors.dart';
import '../../styles/button_styles.dart';
import '../../widgets/custom_spacer.dart';
import '../../widgets/screen_decor.dart';

class ForgetPasswordScreen extends StatefulWidget {
  @override
  _ForgetPasswordScreenState createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final MyAppController _app = Get.find();
  var forget = GlobalKey<FormState>();
  String email;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            topDecor(width: 321, height: 160.5,),
            vspace(height: 40),
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
                    child: Form(
                      key: forget,
                      child: Column(
                        children: [
                          vspace(height: 40),
                          Padding(
                            padding: EdgeInsets.only(
                                top: 60, left: 20, right: 20, bottom: 20),
                            child: Text(
                              'RESET YOUR PASSWORD',
                              style: TextStyle(
                                  fontFamily: 'Futura',
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          vspace(height: 70),
                          Padding(
                            padding: EdgeInsets.only(
                                left: 20, right: 20, top: 0.0, bottom: 0.0),
                            child: TextFormField(
                              maxLines: 1,
                              cursorColor: primaryColor,
                              keyboardType: TextInputType.emailAddress,
                              onChanged: (val) {
                                email = val;
                              },
                              style: TextStyle(
                                fontFamily: 'Futura',
                                color: Colors.black,
                              ),
                              validator: (val) {
                                if (val.isEmpty) {
                                  return "*Required";
                                } else if (!GetUtils.isEmail(val)) {
                                  return 'Please enter a valid email address';
                                } else {
                                  return null;
                                }
                              },
                              decoration: InputDecoration(
                                labelText: 'Enter your email address',
                                labelStyle: TextStyle(
                                  fontFamily: 'Futura',
                                  color: Colors.black,
                                ),
                                filled: true,
                                fillColor: Colors.grey.withOpacity(0.5),
                                errorStyle: TextStyle(
                                  fontFamily: 'Futura',
                                  color: primaryColor,
                                ),
                                prefixIcon:
                                    Icon(Icons.email, color: primaryColor),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey.withOpacity(0.5)),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(2.0)),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  gapPadding: 2.0,
                                  borderSide: BorderSide(
                                      color: Colors.grey.withOpacity(0.5)),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(2.0)),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  gapPadding: 2.0,
                                  borderSide: BorderSide(
                                      color: Colors.grey.withOpacity(0.5)),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(2.0)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  gapPadding: 2.0,
                                  borderSide: BorderSide(
                                      color: Colors.grey.withOpacity(0.5)),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(2.0)),
                                ),
                                border: OutlineInputBorder(
                                  gapPadding: 2.0,
                                  borderSide: BorderSide(
                                      color: Colors.grey.withOpacity(0.5)),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(2.0)),
                                ),
                              ),
                            ),
                          ),
                          vspace(height: 80),
                          Container(
                            width: 235,
                            height: 50,
                            child: OutlinedButton(
                              child: Text("RESET NOW",
                                  style: TextStyle(
                                    fontFamily: 'Futura',
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                              onPressed: () {
                                if (forget.currentState.validate()) {
                                  print('clicked');
                                  _app
                                      .resetPassword(
                                    email: email,
                                  )
                                      .then((value) {
                                    if (value) {
                                      Get.toNamed('/forgetAlert', arguments: email);
                                    }
                                  });
                                  forget.currentState.save();
                                }
                              },
                              style: outlinebutton(
                                surface: Colors.grey.withOpacity(0.5),
                                primary: primaryColor,
                                borderColor: primaryColor,
                              ),
                            ),
                          ),
                          // vspace(height: 120),
                          vspace(height: 70),
                          copyrightwidget(color: primaryColor),
                          vspace(height: 10),
                        ],
                      ),
                    ),
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black,
                              offset: Offset(0, 10),
                              blurRadius: 10),
                        ]),
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
                          child: Image.asset(
                            'assets/images/pic.png',
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
