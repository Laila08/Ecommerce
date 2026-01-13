import 'package:ecommerceapp/core/components/widgets/app_dialog.dart';
import 'package:ecommerceapp/core/components/widgets/app_text_field.dart';
import 'package:ecommerceapp/core/components/widgets/main_button.dart';
import 'package:ecommerceapp/core/extensions/app_extentions.dart';
import 'package:ecommerceapp/core/routes/routes.dart';
import 'package:ecommerceapp/core/utils/app_assets.dart';
import 'package:ecommerceapp/core/utils/app_colors.dart';
import 'package:ecommerceapp/core/utils/app_messages.dart';
import 'package:ecommerceapp/core/theme/app_text_styles.dart';
import 'package:ecommerceapp/core/theme/app_validator.dart';
import 'package:ecommerceapp/core/controllers/auth/auth_cubit.dart';
import 'package:ecommerceapp/core/views/widgets/social_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'action_text_widget.dart';
import 'suffix_icon_widget.dart';

class LoginFormWidget extends StatelessWidget {
  const LoginFormWidget({super.key});

  Future<void> login(AuthCubit authCubit) async {
    if (authCubit.state is AuthFormState) {
      final state = authCubit.state as AuthFormState;
      if (state.isValidEmail != true ||
          state.isValidPassword != true ) {
        authCubit.enableAutoValidate();
        return;
      }
    }
    await authCubit.login();
    authCubit.clearForm();
  }

  @override
  Widget build(BuildContext context) {
    final authCubit = BlocProvider.of<AuthCubit>(context);
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        bool? isValidEmail;
        bool? isValidPassword;
        AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

        if (state is AuthFormState) {
          isValidEmail = state.isValidEmail;
          isValidPassword = state.isValidPassword;
          autovalidateMode = state.autovalidateMode;
        }
        return Column(
          spacing: 12,
          children: [
            AppTextField(
              onChangedFunction: (_) => authCubit.validateEmail(),
              labelText: "Email",
              focusNodeType: authCubit.emailFocusNode,
              validator: AppValidator.emailValidator,
              controller: authCubit.emailController,
              autovalidateMode: autovalidateMode,
              suffixIcon: SuffixIconWidget.getSuffixIcon(isValidEmail),
              textInputAction: TextInputAction.next,
              onEditingCompleteFun: () =>
                  FocusScope.of(
                    context,
                  ).requestFocus(authCubit.passwordFocusNode),
            ),
            AppTextField(
              autovalidateMode: autovalidateMode,
              onChangedFunction: (_) => authCubit.validatePassword(),
              suffixIcon: SuffixIconWidget.getSuffixIcon(isValidPassword,),
              labelText: "Password",
              controller: authCubit.passwordController,
              focusNodeType: authCubit.passwordFocusNode,
              validator: AppValidator.passwordValidator,
              textInputAction: TextInputAction.done,
            ),
            ActionTextWidget(
              title: 'Forgot your password?',
              routeName: Routes.forgotPassword,
            ),
            5.verticalSizedBox,
            BlocConsumer<AuthCubit, AuthState>(
              bloc: authCubit,
              listenWhen: (previous, current) =>
              current is AuthSuccess || current is AuthFailed,
              listener: (context, state) {
                if (state is AuthFailed) {
                  showDialog(
                    context: context,
                    builder: (_) =>
                        AppDialog(message: AppMessages.loginErrorMessage),
                  );
                }if (state is AuthSuccess) {
                  context.pushReplacementNamed(Routes.homepage);
                }
              },
              builder: (context, state) {
                if (state is AuthLoading) {
                  return MainButton(child: CircularProgressIndicator(color: AppColors.whiteColor,).center(),);
                }
                return MainButton(
                  title: "LOGIN",
                  onTap: () async {
                    await login(authCubit);
                  },
                );
              },
            ),
            110.verticalSizedBox,
            Text(
              "Or login with social account",
              style: AppTextStyles.font14blackWeight500,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SocialWidget(image: AppAssets.gmailImg),
                SocialWidget(image: AppAssets.facebookImg).allPading(20),
              ],
            ),
          ],
        );
      },
    );
  }
}
