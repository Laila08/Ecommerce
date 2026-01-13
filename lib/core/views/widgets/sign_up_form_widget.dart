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

class SignUpFormWidget extends StatelessWidget {
  const SignUpFormWidget({super.key});

  Future<void> signup(AuthCubit authCubit) async {
    if (authCubit.state is AuthFormState) {
      final state = authCubit.state as AuthFormState;
      if (state.isValidEmail != true ||
          state.isValidPassword != true ||
          state.isValidName != true) {
        authCubit.enableAutoValidate();
        return;
      }
    }
    await authCubit.signUp();
    authCubit.clearForm();
  }

  @override
  Widget build(BuildContext context) {
    final authCubit = BlocProvider.of<AuthCubit>(context);
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        bool? isValidEmail;
        bool? isValidPassword;
        bool? isValidName;
        AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

        if (state is AuthFormState) {
          isValidEmail = state.isValidEmail;
          isValidPassword = state.isValidPassword;
          isValidName = state.isValidName;
          autovalidateMode = state.autovalidateMode;
        }
        return Column(
          spacing: 12,
          children: [
            AppTextField(
              suffixIcon: SuffixIconWidget.getSuffixIcon(isValidName),
              labelText: "Name",
              controller: authCubit.nameController,
              focusNodeType: authCubit.nameFocusNode,
              validator: AppValidator.nameValidator,
              textInputAction: TextInputAction.next,
              autovalidateMode: autovalidateMode,
              onChangedFunction: (_) => authCubit.validateName(),
              onEditingCompleteFun: () =>
                  FocusScope.of(context).requestFocus(authCubit.emailFocusNode),
            ),
            AppTextField(
              onChangedFunction: (_) => authCubit.validateEmail(),
              labelText: "Email",
              focusNodeType: authCubit.emailFocusNode,
              validator: AppValidator.emailValidator,
              controller: authCubit.emailController,
              autovalidateMode: autovalidateMode,
              suffixIcon: SuffixIconWidget.getSuffixIcon(isValidEmail,),
              textInputAction: TextInputAction.next,
              onEditingCompleteFun: () => FocusScope.of(
                context,
              ).requestFocus(authCubit.passwordFocusNode),
            ),
            AppTextField(
              onChangedFunction: (_) => authCubit.validatePassword(),
              suffixIcon: SuffixIconWidget.getSuffixIcon(isValidPassword,),
              labelText: "Password",
              controller: authCubit.passwordController,
              focusNodeType: authCubit.passwordFocusNode,
              validator: AppValidator.passwordValidator,
              textInputAction: TextInputAction.done,
            ),
            ActionTextWidget(
              title: 'Already have an account?',
              routeName: Routes.login,
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
                }
                if (state is AuthSuccess) {
                  context.pushReplacementNamed(Routes.homepage);
                }
              },
             builder: (context, state) {
                if (state is AuthLoading) {
                  return MainButton(
                    onTap: null,
                    child: CircularProgressIndicator(
                      color: AppColors.whiteColor,
                    ).center(),
                  );
                }
                return MainButton(
                  title: "Sign Up",
                  onTap: () async {
                    await signup(authCubit);
                  },
                );
              },
            ),
            110.verticalSizedBox,
            Text(
              "Or sign up with social account",
              style: AppTextStyles.font14blackWeight500,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SocialWidget(image: AppAssets.gmailImg),
                SocialWidget(image: AppAssets.facebookImg).allPading(15),
              ],
            ),
          ],
        );
      },
    ).horizontalPadding(14);
  }
}
