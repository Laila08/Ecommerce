import 'package:ecommerceapp/core/extensions/app_extentions.dart';
import 'package:ecommerceapp/core/utils/app_colors.dart';
import 'package:ecommerceapp/core/theme/app_text_styles.dart';
import 'package:ecommerceapp/core/views/widgets/auth_widgets/sign_up_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return false;
      },
      child: Scaffold(
        backgroundColor: AppColors.backGroundColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            100.verticalSizedBox,
            Text("Sign up", style: AppTextStyles.font34BlackWeight700),
            60.verticalSizedBox,
            Expanded(child: SingleChildScrollView(physics: ClampingScrollPhysics(),child: SignUpFormWidget())),
          ],
        ).horizontalPadding(14),
      ),
    );
  }
}