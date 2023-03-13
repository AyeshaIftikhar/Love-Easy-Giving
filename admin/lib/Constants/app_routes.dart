import '../Screens/Admins/add_admin.dart';
import '../Screens/Admins/change_password.dart';
import '../Screens/Admins/app_admins.dart';
import '../Screens/Hajj/add_charities.dart';
import '../Screens/Hajj/add_qurbani_basket.dart';
import '../Screens/Jummah/add_individual_mosque.dart';
import '../Screens/Jummah/add_mosque.dart';
import '../Screens/Ramadan/add_charity_cause.dart';
import '../Screens/Ramadan/add_ramadan_charities.dart';
import '../Screens/Users/app_users.dart';
import '../Screens/History/donation_history.dart';
import '../Screens/Hajj/hajj.dart';
import '../Screens/home_screen.dart';
import '../Screens/Auth/login_screen.dart';
import '../Screens/Jummah/jummah_individual.dart';
import '../Screens/main_screen.dart';
import '../Screens/Jummah/mosque.dart';
import '../Screens/Ramadan/ramadan.dart';
import 'package:get/get.dart';

var appPages = [
  GetPage(name: '/', page: () => const MainScreen()),
  GetPage(name: '/Home', page: () => const HomeScreen()),
  GetPage(name: '/Login', page: () => const LoginScreen()),
  GetPage(name: '/ChangePassword', page: () => const ChangePassword()),
  GetPage(name: '/LoveRamadan', page: () => LoveRamadan()),
  GetPage(name: '/LoveHajj', page: () => LoveHajj()),
  GetPage(name: '/Mosque', page: () => GeneralMosque()),
  GetPage(name: '/DonationHistory', page: () => DonationHistory()),
  GetPage(name: '/JummahIndividual', page: () => JummahIndividual()),
  GetPage(name: '/AppUsers', page: () => AppUsers()),
  GetPage(name: '/AppAdmins', page: () => AppAdmins()),
  GetPage(name: '/AddAdmin', page: () => AddAdmin()),
  GetPage(name: '/HajjCharities', page: () => const AddHajjCharities()),
  GetPage(name: '/QurbaniBasket', page: () => const AddQurbaniBasket()),
  GetPage(name: '/RamadanCharities', page:()=> const AddRamadanCharities()),
  GetPage(name: '/AddCharityCause', page: () => const AddCharityCause()),
  GetPage(name: '/AddMosque', page: () => const AddGeneralMosques()),
  GetPage(name: '/AddIndividualMosque', page: () => const AddIndividualMosque()),
];
