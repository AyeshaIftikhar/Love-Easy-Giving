import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Constants/colors.dart';

AppBar backAppBar() {
  return AppBar(
    leading: IconButton(
      tooltip: 'Exit',
    icon: Icon(Icons.arrow_back_ios, color: primaryColor,),
    onPressed: () => Get.back(),
  ));
}
