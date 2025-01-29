import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../model/res/constant/app_assets.dart';
import '../../../model/res/widgets/app_text.dart.dart';
import '../../../model/res/widgets/app_text_field.dart';
import '../../../model/res/widgets/hover_button_loader.dart';
import '../../../constant.dart';
import '../../../providers/auth/auth_provider.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final emailC = TextEditingController();
  final passwordC = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor.withOpacity(0.45),
      body: Form(
        key: _key,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                SizedBox(
                  height: 100.h,
                  width: 25.w,
                  child: Image.asset(
                    AppAssets.logInImage,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  height: 100.h,
                  width: 25.w,
                  decoration: BoxDecoration(
                    color: primaryColor.withOpacity(0.45),
                  ),
                ),
              ],
            ),
            const Spacer(),
            SizedBox(
              width: 35.w,
              height: 100.h,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: SizedBox(
                      height: 30.h,
                      child: Image.asset(AppAssets.logoImage),
                    ),
                  ),
                  SizedBox(height: 4.h),
                  AppTextWidget(
                    text: "Email",
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                  SizedBox(height: 1.h),
                  AppTextField(
                    controller: emailC,
                    hintText: "Enter Email",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email is required';
                      } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                        return 'Enter a valid email address';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 3.h),
                  AppTextWidget(
                    text: "Password",
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                  SizedBox(height: 1.h),
                  AppTextField(
                    controller: passwordC,
                    hintText: "Enter Password",
                    obscureText: false,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password is required';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 8.h),
                  HoverLoadingButton(
                    width: 20.w,
                    height: 5.h,
                    text: 'Continue',
                    onClicked: () async {
                      if (_key.currentState!.validate()) {
                     await   context.read<AuthProvider>().signInUser(
                          email: emailC.text.trim(),
                          password: passwordC.text.trim(),
                          context: context,
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
