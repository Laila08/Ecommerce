import 'package:ecommerceapp/core/components/widgets/app_text_field.dart';
import 'package:ecommerceapp/core/components/widgets/arrow_back_icon.dart';
import 'package:ecommerceapp/core/components/widgets/main_button.dart';
import 'package:ecommerceapp/core/controllers/auth_controller.dart';
import 'package:ecommerceapp/core/extensions/app_extentions.dart';
import 'package:ecommerceapp/core/utils/app_colors.dart';
import 'package:ecommerceapp/core/theme/app_text_styles.dart';
import 'package:ecommerceapp/core/theme/app_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'widgets/suffix_icon_widget.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});
  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      appBar: AppBar(
        leading: ArrowBackIcon(),
        backgroundColor: AppColors.backGroundColor,
      ),
      body: Consumer<AuthController>(
        builder: ( context,model,child) {
          return Form(
            key:model.forgotPasswordKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                18.verticalSizedBox,
                Text("Forgot password", style: AppTextStyles.font34WhiteWeight700),
                73.verticalSizedBox,
                Text(
                  "Please, enter your email address. You will receive \na link to create a new password via email.",
                  style: AppTextStyles.font14blackWeight500,
                ).onlyPadding(bottomPadding: 20),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        10.verticalSizedBox,
                        AppTextField(
                          onChangedFunction: (_) => model.validateEmail(),
                          labelText: "Email",
                          focusNodeType: model.emailFocusNode,
                          validator: AppValidator.emailValidator,
                          controller: model.emailController,
                          textInputAction: TextInputAction.done,
                          suffixIcon: SuffixIconWidget.getSuffixIcon(model.isValidEmail),
                          keyboardType: TextInputType.emailAddress,),
                        60.verticalSizedBox,
                        MainButton(title: "SEND",onTap: (){},),
                        150.verticalSizedBox,
                      ],
                    ),
                  ),
                ),
              ],
            ).horizontalPadding(14),
          );
        },
      ),
    );
  }
}
