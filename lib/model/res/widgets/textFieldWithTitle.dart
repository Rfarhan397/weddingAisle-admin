
import 'package:flutter/cupertino.dart';
import 'package:sizer/sizer.dart';

import 'app_text.dart.dart';
import 'app_text_field.dart';

class AppTextFieldWithTitle extends StatelessWidget {
  final String text,hintText;
  final TextEditingController?   controller;
   AppTextFieldWithTitle({super.key, required this.text, this.controller,required this.hintText});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppTextWidget(text: text,fontSize: 14,fontWeight: FontWeight.w600,),
        SizedBox(height: 1.h,),
        SizedBox(
            width: 30.w,
            child: AppTextField(hintText: hintText,radius: 4,controller: controller,))
      ],
    );
  }
}
