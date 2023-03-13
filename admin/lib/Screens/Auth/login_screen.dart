import '../../Constants/colors.dart';
import '../../Controller/app_controller.dart';
import '../../styles/button_styles.dart';
import '../../styles/input_decoration.dart';
import '../../widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _login = GlobalKey<FormState>();
  final MyAppController _app = Get.find();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _login,
          child: Column(
            children: <Widget>[
              const SizedBox(height: 70),
              Center(
                child: Image.asset(
                  'assets/images/easylovegiving.png',
                  width: Get.width * 0.4,
                ),
              ),
              const SizedBox(height: 10),
              const TextWidget(
                text: 'Login Here!',
                size: 20,
                weight: FontWeight.bold,
                alignment: Alignment.center,
                color: Color(0xffB08850),
              ),
              const SizedBox(height: 30),
              Card(
                child: Container(
                  width: Get.width * 0.4,
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      TextFormField(
                        autofocus: true,
                        controller: username,
                        maxLines: 1,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        style:
                            const TextStyle(fontFamily: 'Futura', color: htextColor),
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'Username is required';
                          }
                          return null;
                        },
                        decoration: inputDecoration(
                          hint: 'Username',
                          focusColor: const Color(0xffB08850),
                          textColor: Colors.grey,
                          borderColor: const Color(0xffB08850),
                          errorColor: const Color(0xffB08850),
                        ),
                      ),
                      TextFormField(
                        controller: password,
                        maxLines: 1,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        style:
                            const TextStyle(fontFamily: 'Futura', color: htextColor),
                        obscureText: !showPassword ? true : false,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'Password is required';
                          }
                          return null;
                        },
                        decoration: inputDecoration(
                          hint: 'Password',
                          focusColor: const Color(0xffB08850),
                          textColor: Colors.grey,
                          borderColor: const Color(0xffB08850),
                          errorColor: const Color(0xffB08850),
                          suffix: IconButton(
                            onPressed: () {
                              setState(() {
                                showPassword = !showPassword;
                              });
                            },
                            color: !showPassword
                                ? Colors.grey
                                : const Color(0xffB08850),
                            icon: Icon(!showPassword
                                ? Icons.remove_red_eye_outlined
                                : Icons.remove_red_eye),
                          ),
                        ),
                      ),

                      // ignore: sized_box_for_whitespace
                      Container(
                        width: 200,
                        margin: const EdgeInsets.only(top: 60),
                        child: ElevatedButton(
                          child: const TextWidget(
                            text: 'Login',
                            size: 17,
                            alignment: Alignment.center,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            if (_login.currentState!.validate()) {
                              _app.login(
                                  username: username.text,
                                  password: password.text);
                              _login.currentState!.save();
                            }
                          },
                          style: elevatedButton(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
