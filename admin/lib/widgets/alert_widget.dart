import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: invalid_required_positional_param
showSnackbar(
    {required String title, required String body, Color? color}) async {
  return Get.snackbar(title, body, backgroundColor: color);
}
