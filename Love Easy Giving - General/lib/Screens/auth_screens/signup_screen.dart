import 'package:leggenerral/widgets/copyright.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../Controller/app_controller.dart';
import '../../Constants/colors.dart';
import '../../widgets/const_widgets.dart';
import '../../widgets/custom_spacer.dart';
import '../../widgets/custom_text_form_field.dart';
import '../../widgets/text_widget.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final MyAppController _app = Get.find();
  var signupKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phoneNo = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController postcode = TextEditingController();
  String taxpayer = 'No';
  bool yenable = false;
  bool nenable = false;
  String payer = "GIFT AID (UK Taxpayer)";

  @override
  void dispose() {
    super.dispose();
    name.dispose();
    email.dispose();
    phoneNo.dispose();
    password.dispose();
    address.dispose();
    postcode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldColor,
      body: SingleChildScrollView(
        child: Form(
          key: signupKey,
          child: Column(
            children: [
              constWidgets(width: 321, height: 160.5),
              vspace(height: 20),
              Padding(
                padding: EdgeInsets.all(15),
                child: Column(
                  children: [
                    CustomTextFormField(
                      label: 'FULL NAME',
                      maxLines: 1,
                      keyboardType: TextInputType.name,
                      controller: name,
                      autoFocus: true,
                      textInputAction: TextInputAction.next,
                      validator: (val) {
                        if (val.isEmpty) {
                          return '*Requires';
                        }
                        return null;
                      },
                      decorColor: Colors.white,
                      errorColor: Colors.white,
                      borderColor: Colors.white,
                      focusColor: Colors.white,
                      typedTextColor: Colors.white,
                    ),
                    CustomTextFormField(
                      label: 'EMAIL ADDRESS',
                      maxLines: 1,
                      keyboardType: TextInputType.emailAddress,
                      controller: email,
                      textInputAction: TextInputAction.next,
                      validator: (val) {
                        if (val.isEmpty) {
                          return '*Required';
                        } else if (!GetUtils.isEmail(val)) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                      decorColor: Colors.white,
                      errorColor: Colors.white,
                      borderColor: Colors.white,
                      focusColor: Colors.white,
                      typedTextColor: Colors.white,
                    ),
                    CustomTextFormField(
                      label: 'PHONE NUMBER',
                      maxLines: 1,
                      hint: '91xxxxxxxxxx',
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      controller: phoneNo,
                      textInputAction: TextInputAction.next,
                      // validator: (val) {
                      //   if (val.isEmpty) {
                      //     return '*Required';
                      //   }
                      //   return null;
                      // },
                      decorColor: Colors.white,
                      errorColor: Colors.white,
                      borderColor: Colors.white,
                      focusColor: Colors.white,
                      typedTextColor: Colors.white,
                    ),
                    CustomTextFormField(
                      label: 'PASSWORD',
                      maxLines: 1,
                      keyboardType: TextInputType.text,
                      isPassword: true,
                      controller: password,
                      textInputAction: TextInputAction.next,
                      validator: (val) {
                        if (val.isEmpty) {
                          return '*Required';
                        }
                        return null;
                      },
                      decorColor: Colors.white,
                      errorColor: Colors.white,
                      borderColor: Colors.white,
                      focusColor: Colors.white,
                      typedTextColor: Colors.white,
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 15, bottom: 15),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          appText(
                            text: payer,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                if (taxpayer == '') {
                                  taxpayer = 'Yes';
                                  print('Taxpayer: $taxpayer');
                                  nenable = false;
                                  yenable = true;
                                  print('yenable: $yenable');
                                } else if (taxpayer == 'Yes') {
                                  taxpayer = '';
                                  print('Taxpayer: $taxpayer');
                                  nenable = false;
                                  yenable = false;
                                  print('yenable: $yenable');
                                } else {
                                  taxpayer = 'Yes';
                                  nenable = false;
                                  yenable = true;
                                  print('Taxpayer: $taxpayer');
                                  print(nenable);
                                }
                              });
                            },
                            child: Container(
                              height: 40,
                              width: 55,
                              margin: EdgeInsets.only(left: 20),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.white,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Center(
                                child: Text(
                                  "Yes",
                                  style: TextStyle(
                                    fontFamily: 'Futura',
                                    color:
                                        (yenable == false && taxpayer != 'Yes'
                                            ? Colors.grey
                                            : Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                if (taxpayer == '') {
                                  taxpayer = 'No';
                                  nenable = true;
                                  yenable = false;
                                  print('Taxpayer: $taxpayer');
                                  print(nenable);
                                } else if (taxpayer == 'No') {
                                  taxpayer = '';
                                  nenable = false;
                                  yenable = true;
                                  print('Taxpayer: $taxpayer');
                                  print(nenable);
                                } else {
                                  taxpayer = 'No';
                                  nenable = true;
                                  yenable = false;
                                  print('Taxpayer: $taxpayer');
                                  print(nenable);
                                }
                              });
                            },
                            child: Container(
                              height: 40,
                              width: 55,
                              margin: EdgeInsets.only(left: 15),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.white,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Center(
                                child: Text(
                                  "No",
                                  style: TextStyle(
                                    fontFamily: 'Futura',
                                    color: (nenable == false && taxpayer != 'No'
                                        ? Colors.grey
                                        : Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    appText(
                      text: 'ADDRESS',
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                    CustomTextFormField(
                      label: 'ENTER ADDRESS',
                      maxLines: 1,
                      keyboardType: TextInputType.streetAddress,
                      controller: address,
                      textInputAction: TextInputAction.next,
                      // validator: (val) {
                      //   if (val.isEmpty) {
                      //     return '*Required';
                      //   }
                      //   return null;
                      // },
                      decorColor: Colors.white,
                      errorColor: Colors.white,
                      borderColor: Colors.white,
                      focusColor: Colors.white,
                      typedTextColor: Colors.white,
                    ),
                    vspace(height: 30),
                    appText(
                      text: 'POSTCODE',
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                    CustomTextFormField(
                      label: 'ENTER POSTCODE',
                      maxLines: 1,
                      keyboardType: TextInputType.text,
                      controller: postcode,
                      // validator: (val) {
                      //   if (val.isEmpty) {
                      //     return '*Required';
                      //   }
                      //   return null;
                      // },
                      decorColor: Colors.white,
                      errorColor: Colors.white,
                      borderColor: Colors.white,
                      focusColor: Colors.white,
                      typedTextColor: Colors.white,
                    ),
                  ],
                ),
              ),
              Container(
                width: 235,
                height: 55,
                margin: EdgeInsets.only(top: 40),
                padding: EdgeInsets.all(5),
                child: OutlinedButton(
                  onPressed: () {
                    if (taxpayer == '') {
                      setState(() {
                        payer = '*Required';
                      });
                    } else {
                      if (signupKey.currentState.validate()) {
                        print('pressed');
                        _app
                            .userSignup(
                          email: email.text,
                          password: password.text,
                          name: name.text,
                        )
                            .then((user) {
                          if (user != null) {
                            _app.userRef.doc(user.uid).set({
                              'userid': user.uid,
                              'name': name.text,
                              'email': email.text,
                              'phoneNo': '+' + phoneNo.text,
                              'taxpayer': taxpayer,
                              'address': address.text.isNotEmpty ?{
                                'line1': address.text.split(',')[0],
                                'line2': address.text.split(',')[1],
                                'city': address.text.split(',')[2],
                                'state': address.text.split(',')[3],
                                'country': address.text.split(',')[4],
                              }: {},
                              'postCode': postcode.text,
                              'creationTime': DateTime.now(),
                            });
                            if (phoneNo.text.isNotEmpty)
                              Get.toNamed('/otpScreen',
                                  arguments: '+' + phoneNo.text);
                            else {
                              Get.offAllNamed('/homePage');
                            }
                          }
                        });
                        signupKey.currentState.save();
                      }
                    }
                  },
                  child: Text(
                    "SIGN UP",
                    style: TextStyle(
                        fontFamily: 'Futura',
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              vspace(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Already have an account ",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Futura',
                      fontSize: 16,
                    ),
                  ),
                  InkWell(
                    child: Text(
                      "Sign In",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Futura',
                        fontSize: 16,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    onTap: () => Get.toNamed('/login'),
                  ),
                ],
              ),
              // vspace(height: 30),
              vspace(height: 20),
              copyrightwidget(),
              vspace(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
