import 'dart:async';
import '../Constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stripe_payment/stripe_payment.dart';
import '../Controller/app_controller.dart';
import '../widgets/alert_widgets.dart';
import './payment_service.dart';

Timer timer;
Future<void> scheduledTimer({
  @required int difference,
  @required int amount,
  @required String currency,
  @required CreditCard card,
  @required String mosqueName,
  @required String description,
  @required BillingAddress billingAddress,
  @required DateTime startDate,
  @required DateTime endDate,
  @required String time,
  @required Color backgroundColor,
  @required String app,
  @required String unicode,
}) async {
  final MyAppController _controller = Get.find();
  timer = Timer.periodic(Duration(days: difference), (timer) async {
    final SharedPreferences _prefs = await SharedPreferences.getInstance();
    if (DateTime.now().isBefore(startDate)) {
      Future.delayed(Duration(hours: 24));
    } else {
      StripeService.payWithCard(
        amount: amount.toString(),
        currency: currency,
        card: card,
        description: description,
        name: _prefs.getString('username'),
        phone: _prefs.getString('userPhone'),
        email: _prefs.getString('user_email'),
        billingAddress: billingAddress
      ).then((transactionRespone) {
        if (transactionRespone.success) {
          print('success');
          _controller.givingRef.add({
            'userid': _controller.userid.value,
            'MosqueName': mosqueName,
            'Amount': (amount / 100).toString(),
            'Reason': description,
            'Payment Date': DateTime.now(),
            'Time': DateTime.now(),
            'appmode': app,
            'unicode': unicode.replaceAll('\\u', '0x'),
            'AppType': backgroundColor == Colors.white 
                                  ? 'Hajj' 
                                  : backgroundColor == loveJummahScaffold
                                    ? 'Jummah'
                                    : 'Ramadan',
          });
        } else {
          showSnackbar(
              title: 'Somethig went wrong!',
              message: 'Please try again later!');
        }
      });
      Future.delayed(Duration(hours: 24));
    }
    if (endDate.isAfter(DateTime.now())) {
      timer.cancel();
      print('Cancelled');
    }
  });
}

Future<void> scheduleFriday({
  @required int difference,
  @required int amount,
  @required String currency,
  @required CreditCard card,
  @required String mosqueName,
  @required String description,
  @required BillingAddress billingAddress,
  @required DateTime startDate,
  @required DateTime endDate,
  @required String time,
  @required Color backgroundColor,
  @required String app,
  @required String unicode,
}) async{
  final MyAppController _controller = Get.find();
  timer = Timer.periodic(Duration(days: difference), (timer) async {
    final SharedPreferences _prefs = await SharedPreferences.getInstance();
    if (DateTime.now().isBefore(startDate)) {
      Future.delayed(Duration(hours: 24));
    } else {
      if (DateTime.now().weekday == 5) {
        print('Friday');
        StripeService.payWithCard(
        amount: amount.toString(),
        currency: currency,
        card: card,
        description: description,
        name: _prefs.getString('username'),
        phone: _prefs.getString('userPhone'),
        email: _prefs.getString('user_email'),
        billingAddress: billingAddress,
      ).then((transactionRespone) {
        if (transactionRespone.success) {
          print('success');
          _controller.givingRef.add({
            'userid': _controller.userid.value,
            'MosqueName': mosqueName,
            'Amount': (amount / 100).toString(),
            'Reason': description,
            'Payment Date': DateTime.now(),
            'Time': DateTime.now(),
            'appmode': app,
            'unicode': unicode.replaceAll('\\u', '0x'),
            'AppType': backgroundColor == Colors.white 
                                  ? 'Hajj' 
                                  : backgroundColor == loveJummahScaffold
                                    ? 'Jummah'
                                    : 'Ramadan',
          });
        } else {
          showSnackbar(
              title: 'Somethig went wrong!',
              message: 'Please try again later!');
        }
      });
      }
      Future.delayed(Duration(hours: 24));
    }
    if (endDate.isAfter(DateTime.now())) {
      timer.cancel();
      print('Cancelled');
    }
  });
}