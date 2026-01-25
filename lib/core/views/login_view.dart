import 'package:ecommerceapp/core/components/widgets/arrow_back_icon.dart';
import 'package:ecommerceapp/core/extensions/app_extentions.dart';
import 'package:ecommerceapp/core/utils/app_colors.dart';
import 'package:ecommerceapp/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

import 'widgets/auth_widgets/login_form_widget.dart';
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
          ArrowBackIcon().onlyPadding(topPadding: 55,bottomPadding: 40),
          Text("Login", style: AppTextStyles.font34BlackWeight700),
          60.verticalSizedBox,
          Expanded(child: SingleChildScrollView(physics: ClampingScrollPhysics(),child: LoginFormWidget())),
        ],
      ).horizontalPadding(14),
    );
  }
}