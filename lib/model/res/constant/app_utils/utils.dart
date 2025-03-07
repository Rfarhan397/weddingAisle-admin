import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
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
  String formatTimestamp(String timestamp) {
    try {
      int millisecondsSinceEpoch = int.parse(timestamp);
      DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch);
      return DateFormat('dd MMM yyyy, hh:mm a').format(dateTime); // Example: "05 Oct 2023, 12:34 PM"
    } catch (e) {
      // Handle errors (e.g., invalid timestamp format)
      return "Invalid Date";
    }
  }
}
