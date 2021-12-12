import '../../widgets/copyright.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Controller/app_controller.dart';
import '../../Constants/colors.dart';
import '../../widgets/alert_widgets.dart';
import '../../widgets/const_widgets.dart';
import '../../widgets/custom_spacer.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final MyAppController _app = Get.find();
  var loginKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  String password;
  @override
  void dispose() {
    super.dispose();
    email.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldColor,
      persistentFooterButtons: [copyrightwidget()],
      body: SingleChildScrollView(
        child: Form(
          key: loginKey,
          child: Column(
            children: [
              constWidgets(width: 321, height: 160.5,),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    TextFormField(
                      maxLines: 1,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      style: TextStyle(
                        fontFamily: 'Futura',
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        labelText: "EMAIL ADDRESS",
                      ),
                      controller: email,
                      validator: (val) {
                        if (val.isEmpty) {
                          return "*Required";
                        } else if (!GetUtils.isEmail(val)) {
                          return "Please enter a valid email address.";
                        } else {
                          return null;
                        }
                      },
                    ),
                    TextFormField(
                      maxLines: 1,
                      obscureText: true,
                      keyboardType: TextInputType.text,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      style: TextStyle(
                        fontFamily: 'Futura',
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        labelText: "PASSWORD",
                      ),
                      onChanged: (val) {
                        password = val;
                      },
                      validator: (val) {
                        if (val.isEmpty) {
                          return '*Required';
                        } else {
                          return null;
                        }
                      },
                    ),
                  ],
                ),
              ),
              vspace(height: 30),
              Container(
                child: IconButton(
                  icon: Icon(Icons.arrow_forward, color: Colors.white),
                  tooltip: 'Login',
                  onPressed: () {
                    if (loginKey.currentState.validate()) {
                      print("Login pressed");
                      print(email.text);
                      print(password);
                      _app
                          .userLogin(
                        email: email.text,
                        password: password,
                      )
                          .then((user) {
                        if (user != null) {
                          showSnackbar(
                              title: "Success",
                              message: "You have been logged in successfully.");
                          Get.offAllNamed("/homePage");
                        } else {
                          print('Try Again');
                          showSnackbar(
                              title: "Something went wrong!",
                              message: "Please try again later!");
                        }
                      });

                      loginKey.currentState.save();
                    }
                  },
                ),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/heart.png'),
                  ),
                ),
              ),
              vspace(height: 40),
              TextButton(
                  child: Text(
                    "REGISTER NOW",
                    style: TextStyle(
                      fontFamily: 'Futura',
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      color: Colors.white,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  onPressed: () => Get.toNamed('/signup')),
              vspace(height: 2),
              InkWell(
                  child: Text(
                    'Forget Password',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Futura',
                      fontSize: 16,
                    ),
                  ),
                  onTap: () => Get.toNamed('/forgetPassword')),
            ],
          ),
        ),
      ),
    );
  }
}
