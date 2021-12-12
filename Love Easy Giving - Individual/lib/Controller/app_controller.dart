import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/alert_widgets.dart';

class MyAppController extends GetxController {
  RxBool isInternetConnected = false.obs;
  RxBool privacyAccepted = false.obs;
  RxBool isUserLogin = false.obs;
  RxBool isRamadan = false.obs;
  RxBool isJummah = false.obs;
  RxBool isHajj = false.obs;
  RxString userpassword = ''.obs;
  RxString cardNumber = ''.obs;
  RxString holderName = ''.obs;
  RxString expiry = ''.obs;
  RxString userEmail = ''.obs;
  RxString userPhone = ''.obs;
  RxString addLine1 = ''.obs;
  RxString addLine2 = ''.obs;
  RxString username = ''.obs;
  RxString postCode = ''.obs;
  RxString country = ''.obs;
  RxString userid = ''.obs;
  RxString state = ''.obs;
  RxString city = ''.obs;

  String _verificationId;

  var resendToken;

  /// Firebase Firestore
  final mode = FirebaseFirestore.instance.collection('Modes');
  final userRef = FirebaseFirestore.instance.collection('Users');
  final cardRef = FirebaseFirestore.instance.collection('Cards');
  final charRef = FirebaseFirestore.instance.collection('charity');
  final causesRef = FirebaseFirestore.instance.collection('Causes');
  final mosqueRef = FirebaseFirestore.instance.collection('Mosques');
  final charityRef = FirebaseFirestore.instance.collection('Charities');
  final scheduleRef = FirebaseFirestore.instance.collection('Scheduled');
  final givingRef = FirebaseFirestore.instance.collection('GivingHistory');
  final qbasketRef = FirebaseFirestore.instance.collection('QurbaniBasket');
  final cbasketRef = FirebaseFirestore.instance.collection('CauseBasket');
  final cancelPaymentRef =
      FirebaseFirestore.instance.collection('CancelledPayments');
  final searchRef = FirebaseFirestore.instance.collection('MostSearched');

  Future<bool> isFireStoreConnected() async {
    try {
      final SharedPreferences _prefs = await SharedPreferences.getInstance();

      /// Mode
      await mode.doc('mode_type').get().then((_snapshot) {
        isRamadan.value = _snapshot.data()['Ramadan'];
        isJummah.value = _snapshot.data()['Jummah'];
        isHajj.value = _snapshot.data()['Hajj'];
        _prefs.setBool('isRamadan', isRamadan.value);
        _prefs.setBool('isJummah', isJummah.value);
        _prefs.setBool('isHajj', isHajj.value);
      });

      /// username
      await userRef.doc(userid.value).get().then((_snapshot) {
        username.value = _snapshot.data()['name'];
        userPhone.value = _snapshot.data()['phoneNo'];
        addLine1.value = _snapshot.data()['address']["line1"];
        addLine2.value = _snapshot.data()['address']["line2"];
        city.value = _snapshot.data()['address']["city"];
        state.value = _snapshot.data()['address']["state"];
        country.value = _snapshot.data()['address']["country"];
        postCode.value = _snapshot.data()['postCode'];
        _prefs.setString('username', username.value);
        _prefs.setString('userPhone', userPhone.value);
      });

      ///
      return true;
    } catch (e) {
      print("Firestore error:" + e.toString());
      return false;
    }
  }

  /// Firebase Auth
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // ignore: missing_return
  Future<dynamic> userSignup({
    @required String email,
    @required String password,
    @required String name,
  }) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = _auth.currentUser;
      if (!user.emailVerified) {
        await user.sendEmailVerification();
      }
      final SharedPreferences _prefs = await SharedPreferences.getInstance();
      isUserLogin.value = true;
      userid.value = user.uid;
      print(user.uid);
      userEmail.value = user.email;
      username.value = name;
      userpassword.value = password;

      /// cache for maintaining auth
      await _prefs.setBool('isUserLogin', isUserLogin.value);
      await _prefs.setString('user_id', userid.value);
      await _prefs.setString('user_email', userEmail.value);
      await _prefs.setString('username', username.value);
      await _prefs.setString('user_password', userpassword.value);
      print("User Register");
      return user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        print("A user already exists for this email.");
        showSnackbar(
            title: "User Already Exists!",
            message:
                "Looks like you already has a account.\nTry sigining in to your account instead of creating a new account.");
        return null;
      }
    } catch (e) {
      print('Signup Auth Exception: ' + e.toString());
      return null;
    }
  }

  Future<User> userLogin({
    @required String email,
    @required String password,
  }) async {
    try {
      var authUser = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      print('user logged in' + authUser.user.uid);
      final SharedPreferences _prefs = await SharedPreferences.getInstance();
      isUserLogin.value = true;
      userid.value = authUser.user.uid;
      userEmail.value = authUser.user.email;
      // username.value = authUser.user.displayName;
      userpassword.value = password;

      /// cache for maintaining auth
      await _prefs.setBool('isUserLogin', isUserLogin.value);
      await _prefs.setString('user_id', userid.value);
      await _prefs.setString('user_email', userEmail.value);
      // await _prefs.setString('username', username.value);
      await _prefs.setString('user_password', userpassword.value);
      print(isUserLogin.value);
      print(userid.value);
      print(username.value);
      print(userEmail.value);
      print(userpassword.value);

      return authUser.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        showSnackbar(
          title: "Incorrect Email",
          message:
              "We are sorry to inform you that there is no user registered under this email.\nPlease try to login using another email.",
        );
        return null;
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        showSnackbar(
          title: "Incorrect Password",
          message:
              "The password you have entered is incorrect.\nPleases try again with another password.\nIf you have forget your password then try resetting it.",
        );
        return null;
      }
      return null;
    } catch (e) {
      print('Login Auth Exception' + e.toString());
      return null;
    }
  }

  checkUserLoginState() async {
    final SharedPreferences _prefs = await SharedPreferences.getInstance();
    if (_prefs.getBool('isUserLogin') == null) {
      await _prefs.setBool('isUserLogin', false);
      print(_prefs.getBool('isUserLogin'));
    }
    var check = _prefs.getBool('isUserLogin');
    print(check);
    isUserLogin.value = (check ?? false);
    if (isUserLogin.value) {
      userid.value = _prefs.getString('user_id');
      // username.value = _prefs.getString('username');
      userEmail.value = _prefs.getString('user_email');
      userpassword.value = _prefs.getString('user_password');
      print(isUserLogin.value);
      print('User Id:' + userid.value);
      // print(username.value);
      print(userEmail.value);
      print(userpassword.value);
      return true;
    } else {
      return false;
    }
  }

  Future userLogout() async {
    try {
      await _auth.signOut();
      final SharedPreferences _prefs = await SharedPreferences.getInstance();
      isUserLogin.value = false;
      userid.value = '';
      username.value = '';
      userEmail.value = '';
      await _prefs.setBool('isUserLogin', false);
      await _prefs.setString('user_id', '');
      await _prefs.setString('user_email', '');
      await _prefs.setString('username', '');
      await _prefs.setString('user_password', '');
      // _prefs.clear();
      print('Sign Out Successfully!');
      showSnackbar(title: 'Success', message: 'User Logged out!');
      Get.offAllNamed('/login');
    } catch (e) {
      print('Logout Exception' + e.toString());
    }
  }

  @override
  // ignore: override_on_non_overriding_member
  Future<bool> resetPassword({@required String email}) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return true;
    } on FirebaseException catch (e) {
      if (e.code == 'ERROR_USER_NOT_FOUND') {
        showSnackbar(
            title: 'User not found with the mentioned',
            message: 'Try with an other email.');
        return false;
      } else {
        showSnackbar(
            title: 'An internal error has been occured.',
            message: 'Please try again later.');
        return false;
      }
    } catch (e) {
      print("Reset Password Exception:" + e.toString());
      showSnackbar(
          title: "Attention!",
          message:
              "Looks like there is no account related to this email in our database.\nPlease recheck your email address.");
      return false;
    }
  }

  Future phoneNumberVerification({
    @required String phoneNo,
    @required bool isCodeSent,
  }) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNo,
      verificationCompleted: (AuthCredential phoneAuthCredential) async {
        await _auth
            .signInWithCredential(phoneAuthCredential)
            .then((value) async {
          print(phoneNo);
          Get.offAllNamed('/homePage');
        }).catchError((e) {
          print('Verification Complete Error:' + e.toString());
          showToast(message: 'Something went wrong.\nPlease try again later.');
        });
      },
      verificationFailed: (authException) {
        if (authException.code == 'invalid-phone-number') {
          print('The provided phone number is not valid.');
          showToast(
            message: authException.message,
          );
          isCodeSent = false;
          print(isCodeSent);
        } else {
          showToast(
            message: authException.message,
          );
          isCodeSent = false;
          print(isCodeSent);
        }
      },
      codeSent: (String verificationId, [int forceResendingToken]) async {
        showToast(
          message: 'Verification code has been sent successfully!',
        );
        _verificationId = verificationId;
        print('Verification id: ' + _verificationId);
        resendToken = forceResendingToken;
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        _verificationId = verificationId;
      },
      timeout: Duration(seconds: 60),
    );
  }

  onFormSubmitted({
    @required String number,
  }) {
    AuthCredential _authCredential = PhoneAuthProvider.credential(
        verificationId: _verificationId, smsCode: number);
    _auth.signInWithCredential(_authCredential).then((value) async {
      if (value != null) {
        final SharedPreferences _prefs = await SharedPreferences.getInstance();
        _prefs.setBool('PrivacyPolicyStatus', privacyAccepted.value);
        privacyAccepted.value = false;
        Get.offAllNamed('/homePage');
      }
    }).catchError((error) {
      showToast(
        message: "Something went wrong",
      );
    });
  }

  checkPrivacyPolicyStatus() async {
    final SharedPreferences _prefs = await SharedPreferences.getInstance();
    if (_prefs.getBool('PrivacyPolicyStatus') == null) {
      _prefs.setBool('PrivacyPolicuStatus', false);
    }
    privacyAccepted.value = (_prefs.getBool('PrivacyPolicyStatus') ?? false);
  }

  otpresendFunction() async {}

  /// Internet Connectivity
  // Future checkInternetConnectivity() async {
  //   var connectivityResult = await (Connectivity().checkConnectivity());
  //   if (connectivityResult == ConnectivityResult.mobile) {
  //     isInternetConnected = true.obs;
  //   } else if (connectivityResult == ConnectivityResult.wifi) {
  //     isInternetConnected = true.obs;
  //   } else if (connectivityResult == ConnectivityResult.none) {
  //     isInternetConnected = false.obs;
  //     showSnackbar(
  //         title: 'Not connected to INTERNET',
  //         message: 'Please check your network state.');
  //   } else {
  //     isInternetConnected = false.obs;
  //     showSnackbar(
  //         title: 'Not connected to INTERNET',
  //         message: 'Please check your network state.');
  //   }
  // }
}
