import 'package:flutter/material.dart';
import 'package:wedding_admin/model/res/widgets/app_text.dart.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: AppTextWidget(text: 'text'),),
    );
  }
}
