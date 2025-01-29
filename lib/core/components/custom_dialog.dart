import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../constant.dart';
import '../../model/res/constant/app_colors.dart';
import '../../model/res/widgets/app_text.dart.dart';
import '../../model/res/widgets/button_widget.dart';


class ConfirmationDialog extends StatelessWidget {
  final String title;
  final String message;
  final String? cancelText;
  final String? confirmText;
  final VoidCallback? onCancel;
  final VoidCallback? onConfirm;
  final Color backgroundColor;
  final Color buttonColor;

  const ConfirmationDialog({
    Key? key,
    this.title = "Confirmation",
    this.backgroundColor = primaryColor,
    this.buttonColor = primaryColor,
    this.message = "Are you sure you want to update status?",
    this.cancelText,
    this.confirmText,
    this.onCancel,
    this.onConfirm,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Dialog(
      backgroundColor: backgroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: SizedBox(
        width:  35.w,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppTextWidget(
                text: title,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: AppColors.appWhiteColor,
              ),
              const SizedBox(height: 16.0),
              AppTextWidget(
                text: message,
                textAlign: TextAlign.center,
                fontSize: 14.0,
                color: AppColors.appWhiteColor,
              ),
              const SizedBox(height: 24.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  if (onCancel != null && cancelText != null)
                    ButtonWidget(
                      text: cancelText!,
                      backgroundColor: buttonColor,
                      onClicked: onCancel!,
                      width:  10.w,
                      height: 5.h,
                      radius: 4,
                      oneColor: true,
                      fontWeight: FontWeight.w700,
                    ),
                  if (onConfirm != null && confirmText != null)
                    ButtonWidget(
                      text: confirmText!,
                      backgroundColor: buttonColor,
                      onClicked: onConfirm!,
                      width: 30.w,
                      height: 5.h,
                      radius: 4,
                      oneColor: true,
                      fontWeight: FontWeight.w700,
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
