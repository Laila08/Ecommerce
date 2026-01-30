import 'package:ecommerceapp/core/views/widgets/auth_widgets/forgot_password_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../controllers/auth/auth_cubit.dart';
import '../extensions/app_extentions.dart';
import '../routes/routes.dart';
import '../theme/app_text_styles.dart';
import '../utils/app_colors.dart';
import '../utils/app_messages.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  final GlobalKey<FormState> forgetPasswordKey = GlobalKey<FormState>();
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
              final cubit = context.read<AuthCubit>();
              cubit.clearForm();
              cubit.focusScopeNode.unfocus();
              context.pushReplacementNamed(Routes.login);
            },
            child: const Icon(
              Icons.arrow_back_ios,
              color: AppColors.blackColor,
            ),
          ).onlyPadding(topPadding: 55, bottomPadding: 40),
          const Text(
            AppMessages.forgotPasswordTitle,
            style: AppTextStyles.font34BlackWeight700,
          ),
          const SizedBox(height: 60),
          Text(
            AppMessages.forgotPasswordSubTitle,
            style: AppTextStyles.font14blackWeight500,
          ).onlyPadding(bottomPadding: 20),
          Expanded(
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: ForgotPasswordContent(),
            ),
          ),
        ],
      ).horizontalPadding(14),
    );
  }
}
