import 'package:ecommerceapp/core/components/widgets/app_text_field.dart';
import 'package:ecommerceapp/core/components/widgets/arrow_back_icon.dart';
import 'package:ecommerceapp/core/components/widgets/main_button.dart';
import 'package:ecommerceapp/core/extensions/app_extentions.dart';
import 'package:ecommerceapp/core/utils/app_colors.dart';
import 'package:ecommerceapp/core/theme/app_text_styles.dart';
import 'package:ecommerceapp/core/theme/app_validator.dart';
import 'package:ecommerceapp/core/controllers/auth/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../components/widgets/suffix_icon_widget.dart';
import '../utils/app_messages.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {

  @override
  Widget build(BuildContext context) {
    final authCubit = BlocProvider.of<AuthCubit>(context);
    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      appBar: AppBar(
        leading: ArrowBackIcon(),
        backgroundColor: AppColors.backGroundColor,
      ),
      body: BlocBuilder<AuthCubit, AuthState>(
        bloc: authCubit,
        builder: (context, state) {
          bool? isValidEmail;
          AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

          if (state is AuthFormState) {
            isValidEmail = state.isValidEmail;
            autovalidateMode = state.autovalidateMode;
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              18.verticalSizedBox,
              Text(
                  "Forgot password", style: AppTextStyles.font34BlackWeight700),
              73.verticalSizedBox,
              Text(
                AppMessages.emailMessage,
                style: AppTextStyles.font14blackWeight500,
              ).onlyPadding(bottomPadding: 20),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      10.verticalSizedBox,
                      AppTextField(
                        autovalidateMode: autovalidateMode,
                        onChangedFunction: (_) => authCubit.validateEmail(),
                        labelText: "Email",
                        focusNodeType: authCubit.emailFocusNode,
                        validator: AppValidator.emailValidator,
                        controller: authCubit.emailController,
                        textInputAction: TextInputAction.done,
                        suffixIcon: SuffixIconWidget.getSuffixIcon(isValidEmail),
                        keyboardType: TextInputType.emailAddress,),
                      60.verticalSizedBox,
                      MainButton(title: "SEND", onTap: () {},),
                      150.verticalSizedBox,
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ).horizontalPadding(14),
    );
  }
}
