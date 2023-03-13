import '../../Constants/colors.dart';
import '../../Controller/app_controller.dart';
import '../../styles/button_styles.dart';
import '../../styles/input_decoration.dart';
import '../../widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final MyAppController _app = Get.find();
  var changePass = GlobalKey<FormState>();
  TextEditingController currentPass = TextEditingController();
  TextEditingController newPass = TextEditingController();
  TextEditingController confirmNew = TextEditingController();
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white.withAlpha(0),
        title: const TextWidget(
          text: 'Change Password',
          weight: FontWeight.bold,
          alignment: Alignment.center,
        ),
        leading: IconButton(
          onPressed: () => Get.offAllNamed('/'),
          icon: const Icon(Icons.arrow_back_ios, color: htextDark),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: changePass,
          child: Center(
            child: Card(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Container(
                width: Get.width * 0.4,
                padding: const EdgeInsets.all(20),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              showPassword = !showPassword;
                            });
                          },
                          child: TextWidget(
                              alignment: Alignment.topRight,
                              text: !showPassword
                                  ? 'Show Password'
                                  : 'Hide Password'),
                        ),
                      ),
                      TextFormField(
                        autofocus: true,
                        controller: currentPass,
                        maxLines: 1,
                        obscureText: !showPassword ? true : false,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        style: const TextStyle(
                            fontFamily: 'Futura', color: htextColor),
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'Current password is required';
                          } else if (val != _app.adminpassword.value) {
                            return 'Incorrect current password';
                          }
                          return null;
                        },
                        decoration: inputDecoration(
                          hint: 'Current Password',
                          focusColor: const Color(0xffB08850),
                          textColor: Colors.grey,
                          borderColor: const Color(0xffB08850),
                          errorColor: const Color(0xffB08850),
                        ),
                      ),
                      TextFormField(
                        controller: newPass,
                        maxLines: 1,
                        obscureText: !showPassword ? true : false,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        style: const TextStyle(
                            fontFamily: 'Futura', color: htextColor),
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'New password field is required';
                          } else if (val == currentPass.text) {
                            return 'Same as current password';
                          }
                          return null;
                        },
                        decoration: inputDecoration(
                          hint: 'New Password',
                          focusColor: const Color(0xffB08850),
                          textColor: Colors.grey,
                          borderColor: const Color(0xffB08850),
                          errorColor: const Color(0xffB08850),
                        ),
                      ),
                      TextFormField(
                        controller: confirmNew,
                        maxLines: 1,
                        obscureText: !showPassword ? true : false,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        style: const TextStyle(
                            fontFamily: 'Futura', color: htextColor),
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'Confirm new password is required';
                          } else if (val != newPass.text) {
                            return 'Password does not match';
                          }
                          return null;
                        },
                        decoration: inputDecoration(
                          hint: 'Confirm New Password',
                          focusColor: const Color(0xffB08850),
                          textColor: Colors.grey,
                          borderColor: const Color(0xffB08850),
                          errorColor: const Color(0xffB08850),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        width: 200,
                        margin: const EdgeInsets.only(top: 60),
                        child: ElevatedButton(
                          child: const TextWidget(
                            text: 'Change Password',
                            size: 17,
                            alignment: Alignment.center,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            if (changePass.currentState!.validate()) {
                              if (_app.adminpassword.value != newPass.text &&
                                  newPass.text == confirmNew.text) {
                                _app.adminsRef.doc(_app.adminId.value).update({
                                  'password': newPass.text,
                                }).then((value) async {
                                  Get.snackbar(
                                      'Password changed successfully', '');
                                  SharedPreferences _prefs =
                                      await SharedPreferences.getInstance();
                                  _prefs.setString(
                                      'admin_password', newPass.text);
                                  // Get.back();
                                  Get.toNamed('/');
                                });
                              }
                              changePass.currentState!.save();
                            }
                          },
                          style: elevatedButton(),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
