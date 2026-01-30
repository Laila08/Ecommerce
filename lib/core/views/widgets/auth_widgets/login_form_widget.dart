import 'package:ecommerceapp/core/controllers/auth/auth_cubit.dart';
import 'package:ecommerceapp/core/extensions/app_extentions.dart';
import 'package:ecommerceapp/core/routes/routes.dart';
import 'package:ecommerceapp/core/theme/app_text_styles.dart';
import 'package:ecommerceapp/core/utils/app_messages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../utils/app_assets.dart';
import '../../../components/widgets/social_widget.dart';
import 'action_text_widget.dart';
import 'email_field.dart';
import 'password_field.dart';
import 'submit_button.dart';

class LoginFormWidget extends StatelessWidget {
  LoginFormWidget({super.key});
  final GlobalKey<FormState> loginKey = GlobalKey<FormState>();

  Future<void> loginUser(AuthCubit authCubit) async {
    final form = loginKey.currentState;
    if (form == null || !form.validate()) {
      authCubit.enableAutoValidate();
      return;
    }
    await authCubit.login();
  }

  @override
  Widget build(BuildContext context) {
    final authCubit = context.read<AuthCubit>();

    return FocusScope(
      node: authCubit.focusScopeNode,
      child: Form(
        key: loginKey,
        child: BlocBuilder<AuthCubit, AuthState>(
          buildWhen: (previous, current) => current is AuthFormState,
          builder: (context, state) {
            final formState = state is AuthFormState ? state : null;

            return Column(
              spacing: 12,
              children: [
                EmailField(
                  authCubit: authCubit,
                  isValidEmail: formState?.isValidEmail,
                  autovalidateMode:
                      formState?.autovalidateMode ?? AutovalidateMode.disabled,
                ),
                PasswordField(
                  authCubit: authCubit,
                  isValidPassword: formState?.isValidPassword,
                  autovalidateMode:
                      formState?.autovalidateMode ?? AutovalidateMode.disabled,
                ),
                ActionTextWidget(
                  title: AppMessages.forgotPassMessageLogin,
                  routeName: Routes.forgotPassword,
                ),
                5.verticalSizedBox,
                SubmitButton(
                  authCubit: authCubit,
                  submit: loginUser,
                  title: AppMessages.loginTitle,
                ),
                110.verticalSizedBox,
                Text(
                  AppMessages.alreadyHaveAccount,
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
        ),
      ),
    );
  }
}
