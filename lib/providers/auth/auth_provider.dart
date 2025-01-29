import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import '../../model/res/constant/app_utils/utils.dart';
import '../../model/res/routes/routes_name.dart';
import '../action/action_provider.dart';

class AuthProvider extends ChangeNotifier {
  Future<void> signInUser({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      ActionProvider.startLoading();
      final adminSnapshot = await FirebaseFirestore.instance
          .collection('admin')
          .where('email', isEqualTo: email)
          .where('password', isEqualTo: password)
          .get();

      if (adminSnapshot.docs.isNotEmpty) {
        ActionProvider.stopLoading();
        AppUtils().showToast(text: "Login Successful");
        context.go(RoutesName.mainScreen);
        log("Login successful");
      } else {
        ActionProvider.stopLoading();
        log('No admin record found for that email and password.');
        AppUtils().showToast(text: "Login failed: No admin record found for that email and password.",
        );
      }
    } catch (e) {
      ActionProvider.stopLoading();
      log('Error: $e');
      AppUtils().showToast(text:"Login failed: An unexpected error occurred.",
      );
    }
  }
}
