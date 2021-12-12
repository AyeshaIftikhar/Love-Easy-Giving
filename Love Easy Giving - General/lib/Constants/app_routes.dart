import 'package:leggenerral/Screens/love_ramadan/cause_screen.dart';
import 'package:leggenerral/Screens/love_ramadan/charity_basket.dart';
import 'package:get/get.dart';
import 'package:leggenerral/Screens/love_ramadan/ramadan_home.dart';
import '../Screens/other_screens/privacy_policy.dart';
import '../Screens/auth_screens/forget_password.dart';
import '../Screens/auth_screens/signup_screen.dart';
import '../Screens/auth_screens/login_screen.dart';
import '../Screens/auth_screens/forget_alert.dart';
import '../Screens/auth_screens/otp_screen.dart';
import '../Screens/commons/giving_history.dart';
import '../Screens/commons/pay_donation.dart';
import '../Screens/commons/select_card.dart';
import '../Screens/commons/add_card.dart';
import '../Screens/love_jummah/u_home.dart';
import '../Screens/love_hajj/qurbani_basket.dart';
import '../Screens/love_hajj/hajj_thanks.dart';
import '../Screens/love_hajj/love_hajj.dart';
import '../Screens/love_hajj/h_home.dart';
import '../Screens/love_ramadan/thanks_ramadan.dart';
import '../Screens/love_jummah/thanks_screen.dart';
import '../Screens/love_ramadan/love_ramadan.dart';
import '../Screens/love_jummah/love_jummah.dart';
import '../Screens/home_page.dart';
import '../Screens/main_page.dart';

var appPages = [
  GetPage(name: '/', page: () => MainScreen()),

  /// Auth Screens
  GetPage(name: '/login', page: () => LoginScreen()),
  GetPage(
    name: '/signup',
    page: () => SignupScreen(),
  ),
  GetPage(
    name: '/forgetPassword',
    page: () => ForgetPasswordScreen(),
  ),
  GetPage(
    name: '/forgetAlert',
    page: () => ForgetAlertScreen(),
  ),
  GetPage(
    name: '/otpScreen',
    page: () => OtpScreen(),
  ),

  /// commons
  GetPage(
    name: '/homePage',
    page: () => HomePage(),
  ),
  GetPage(
    name: '/Uhome',
    page: () => UHome(),
  ),
  GetPage(
    name: '/givingHistory',
    page: () => GivingHistory(),
  ),
  GetPage(
    name: '/addCard',
    page: () => AddCard(),
  ),
  GetPage(
    name: '/selectCard',
    page: () => SelectCard(),
  ),
  GetPage(
    name: '/pay',
    page: () => Donations(),
  ),

  /// Love Ramadan
  GetPage(
    name: '/ramadan',
    page: () => LoveRamadan(),
  ),
  GetPage(
    name: '/Rthanks',
    page: () => RThanksScreen(),
  ),
  GetPage(name: '/Rhome', page: () => RamadanHome()),
  GetPage(name: '/Rcause', page: () => CauseScreen()),
  GetPage(name: '/Rbasket', page: () => CharityBasket()),

  /// Love Hajj
  GetPage(
    name: '/hajj',
    page: () => LoveHajj(),
  ),
  GetPage(
    name: '/hajjHome',
    page: () => HajjHome(),
  ),
  GetPage(
    name: '/basket',
    page: () => QurbaniBasket(),
  ),
  GetPage(
    name: '/hthanks',
    page: () => HThanks(),
  ),

  /// Other Screens
  GetPage(name: '/privacyPolicy', page: () => PrivacyPolicy()),

  /// Love Jummah routes
  GetPage(
    name: '/jummah',
    page: () => LoveJummah(),
  ),
  GetPage(
    name: '/thanksJummah',
    page: () => JThanksScreen(),
  ),
];
