import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../constant.dart';
import '../../../providers/action/action_provider.dart';
import '../constant/app_colors.dart';
import 'app_text.dart.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;
  final double width, height;
  final FontWeight fontWeight;
  final double radius, horizontalPadding, verticalPadding;
  final bool oneColor;
  final Color textColor, borderColor, backgroundColor;
  final bool isShadow;
  final Alignment alignment;

  const ButtonWidget({
    Key? key,
    required this.text,
    required this.onClicked,
    required this.width,
    required this.height,
    this.radius = 50.0,
    this.horizontalPadding = 0.0,
    this.verticalPadding = 0.0,
    this.oneColor = false,
    this.textColor = Colors.white,
    this.borderColor = primaryColor,
    this.backgroundColor = primaryColor,
    this.isShadow = true,
    required this.fontWeight,
    this.alignment = Alignment.centerLeft,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final actionProvider = Provider.of<ActionProvider>(context);

    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      focusColor: Colors.transparent,
      onTap: onClicked,
      child: Align(
        alignment: alignment ,

        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding,
            vertical: verticalPadding,
          ),
          width: width,
          height: height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius),
            border: Border.all(
              width: oneColor ? 1.0 : 0.0,
              color: oneColor ? borderColor : Colors.transparent,
            ),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: const [0.0, 1.0],
              colors: [
                oneColor
                    ? backgroundColor
                    : ( primaryColor),
                oneColor
                    ? backgroundColor
                    : ( primaryColor),
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: isShadow ? 2 : 0,
                blurRadius: isShadow ? 5 : 0,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Center(
            child: actionProvider.isLoading(0)
                ? const CircularProgressIndicator(
              color: AppColors.appBackgroundColor,
            )
                : AppTextWidget(
              text: text,
              fontSize: 12.0,
              color: textColor,
              fontWeight: fontWeight,
            ),
          ),
        ),
      ),
    );
  }
}
