import 'package:ecommerceapp/core/extensions/app_extentions.dart';
import 'package:ecommerceapp/core/utils/app_colors.dart';
import 'package:ecommerceapp/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

import 'widgets/login_form_widget.dart';
class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          100.verticalSizedBox,
          Text("Login", style: AppTextStyles.font34BlackWeight700),
          80.verticalSizedBox,
          Expanded(child: SingleChildScrollView(child: LoginFormWidget())),
        ],
      ).horizontalPadding(14),
    );
  }
}
