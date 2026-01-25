import 'package:ecommerceapp/core/views/widgets/auth_widgets/forgot_password_content.dart';
import 'package:flutter/material.dart';
import '../components/widgets/arrow_back_icon.dart';
import '../extensions/app_extentions.dart';
import '../theme/app_text_styles.dart';
import '../utils/app_colors.dart';

class ForgotPasswordView extends StatelessWidget {
  final GlobalKey<FormState> forgetPasswordKey = GlobalKey<FormState>();

  ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ArrowBackIcon().onlyPadding(topPadding: 55, bottomPadding: 40),
          Text("Forgot password", style: AppTextStyles.font34BlackWeight700),
          60.verticalSizedBox,
          Expanded(
            child: SingleChildScrollView(
              physics: ClampingScrollPhysics(),
              child: ForgotPasswordContent(),
            ),
          ),
        ],
      ).horizontalPadding(14),
    );
  }
}
