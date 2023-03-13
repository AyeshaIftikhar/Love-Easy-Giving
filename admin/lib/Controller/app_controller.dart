import '../Constants/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyAppController extends GetxController {
  RxBool isUserLogin = false.obs;
  RxString adminpassword = ''.obs;
  RxString userName = ''.obs;
  RxString adminName = ''.obs;
  RxString adminId = ''.obs;
  RxString picture = ''.obs;
  RxBool isLoading = true.obs;
  RxBool allowed = false.obs;

  RxBool ramadan = false.obs;
  RxBool hajj = false.obs;

  /// Firebase Firestore
  final mode = FirebaseFirestore.instance.collection('Modes');
  final userRef = FirebaseFirestore.instance.collection('Users');
  final cardRef = FirebaseFirestore.instance.collection('Cards');
  final causesRef = FirebaseFirestore.instance.collection('Causes');
  final mosqueRef = FirebaseFirestore.instance.collection('Mosques');
  final charityRef = FirebaseFirestore.instance.collection('Charities');
  final charRef = FirebaseFirestore.instance.collection('charity');
  final scheduleRef = FirebaseFirestore.instance.collection('Scheduled');
  final givingRef = FirebaseFirestore.instance.collection('GivingHistory');
  final qbasketRef = FirebaseFirestore.instance.collection('QurbaniBasket');
  final cbasketRef = FirebaseFirestore.instance.collection('CauseBasket');
  final cancelPaymentRef =
      FirebaseFirestore.instance.collection('CancelledPayments');
  final adminsRef = FirebaseFirestore.instance.collection('Admin');
  final searchedRef = FirebaseFirestore.instance.collection('MostSearched');

  fetchModes() {
    mode.doc('mode_type').get().then((value) {
      ramadan.value = value.data()?['Ramadan'];
      hajj.value = value.data()?['Hajj'];
    });
  }

  checkUserLogin() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    var check = _prefs.getBool('isUserLogin') ?? false;
    if (check) {
      isUserLogin.value = _prefs.getBool('isUserLogin')!;
      userName.value = _prefs.getString('userName')!;
      adminName.value = _prefs.getString('admin_name')!;
      adminpassword.value = _prefs.getString('admin_password')!;
      adminId.value = _prefs.getString('admin_id')!;
      picture.value = _prefs.getString('admin_pic')!;
      allowed.value = _prefs.getBool('allowed')!;
      print(isUserLogin.value);
      return true;
    } else {
      isUserLogin.value = false;
      return false;
    }
  }

  Future<bool?> login(
      {required String username, required String password}) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    print('username: $username');
    print('password: $password');
    adminsRef
        .where('username', isEqualTo: username)
        .where('password', isEqualTo: password)
        .get()
        .then((snapshot) {
      if (snapshot.docs.isEmpty) {
        isLoading.value = false;
        Get.defaultDialog(
          title: 'Invalid Email and Password',
          middleText: 'Please try again later!',
          textConfirm: 'OKAY',
          confirmTextColor: Colors.white,
          titleStyle: const TextStyle(
            color: primaryDark,
            fontFamily: 'Futura',
            fontSize: 20,
          ),
          middleTextStyle: const TextStyle(
            color: primaryDark,
            fontFamily: 'Futura',
          ),
          onConfirm: () {
            Get.back();
          },
        );
      }
      if (isLoading.value) {
        Get.dialog(
          const CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(primaryDark),
          ),
        );
      }
      if (snapshot.docs.isNotEmpty) {
        for (var doc in snapshot.docs) {
          // ignore: avoid_print
          print(doc["Name"]);
          isUserLogin.value = true;
          adminId.value = doc.id;
          adminName.value = doc['Name'];
          userName.value = doc['username'];
          adminpassword.value = doc['password'];
          picture.value = doc['picture'];
          allowed.value = doc['allowed'];
          _prefs.setBool('isUserLogin', true);
          _prefs.setString('admin_id', adminId.value);
          _prefs.setString('userName', userName.value);
          _prefs.setString('admin_pic', picture.value);
          _prefs.setString('admin_name', adminName.value);
          _prefs.setString('admin_password', adminpassword.value);
          _prefs.setBool('allowed', allowed.value);
          isLoading.value = false;
          Get.offAllNamed('/Home');
        }
        return true;
      } else {
        return false;
      }
    });
  }

  Future<void> logout() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setBool('isUserLogin', false);
    _prefs.setString('admin_id', '');
    _prefs.setString('userName', '');
    _prefs.setString('admin_pic', '');
    _prefs.setString('admin_name', '');
    _prefs.setString('admin_password', '');
    _prefs.setBool('allowed', false);
    _prefs.clear();
    Get.offAllNamed('/');
  }
}
