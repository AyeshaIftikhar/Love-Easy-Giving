import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

showToast({
  @required String message,
}) {
  return Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
  );
}

showSnackbar({
  @required String title,
  @required String message,
  Color textColor,
  SnackPosition snackPosition,
}) {
  Get.snackbar(
    title,
    message,
colorText: textColor,
snackPosition: snackPosition,
  );
}
