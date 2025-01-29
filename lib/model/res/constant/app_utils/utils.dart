import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../app_colors.dart';

class AppUtils {
  showToast({String? text, Color? bgColor, Color? txtColor}) {
    Fluttertoast.showToast(
      msg: text!,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM_LEFT,
      timeInSecForIosWeb: 3,
      backgroundColor: bgColor ?? AppColors.appBlackColor,
      textColor: txtColor ?? AppColors.appWhiteColor,
      fontSize: 14.0,
    );
  }
}
