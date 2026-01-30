import 'package:ecommerceapp/core/components/widgets/arrow_back_icon.dart';
import 'package:ecommerceapp/core/extensions/app_extentions.dart';
import 'package:ecommerceapp/core/routes/routes.dart';
import 'package:ecommerceapp/core/utils/app_colors.dart';
import 'package:ecommerceapp/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../controllers/auth/auth_cubit.dart';
import '../utils/app_messages.dart';
import 'widgets/auth_widgets/login_form_widget.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AuthCubit>().clearForm();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              context.read<AuthCubit>().clearForm();
              context.read<AuthCubit>().focusScopeNode.unfocus();
              context.pushReplacementNamed(Routes.signup);
            },
            child: const Icon(Icons.arrow_back_ios,color: AppColors.blackColor,),
          ).onlyPadding(topPadding: 55, bottomPadding: 40),
          const Text(
            AppMessages.loginTitle,
            style: AppTextStyles.font34BlackWeight700,
          ),
          const SizedBox(height: 60),
          Expanded(
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: LoginFormWidget(),
            ),
          ),
        ],
      ).horizontalPadding(14),
    );
  }
}
