
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../constant.dart';
import '../constant/app_colors.dart';

class AppTextWidget extends StatelessWidget {
  final String text;
  final double fontSize;
  final int? maxLines;
  final FontWeight fontWeight;
  final TextOverflow overflow;
  final TextAlign textAlign;
  final bool softWrap;
  final Color color;
  final Color underlinecolor;
  final TextDecoration textDecoration;
  const AppTextWidget({
    super.key,
    required this.text,
    this.fontWeight = FontWeight.normal,
    this.color = AppColors.appBlackColor,
    this.textAlign = TextAlign.start,
    this.textDecoration = TextDecoration.none,
    this.fontSize = 12,
    this.softWrap = true,
     this.maxLines,
    this.underlinecolor = primaryColor,  this.overflow = TextOverflow.clip,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      softWrap: softWrap,
      overflow: overflow,
      maxLines: maxLines,
      style: TextStyle(
        decoration: textDecoration,
          decorationColor: underlinecolor,
          fontWeight: fontWeight,
          fontSize: fontSize.sp,
          color:  color,
      ),
    );
  }
}