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
    authCubit.clearForm();
  }

  @override
  Widget build(BuildContext context) {
    final AuthCubit authCubit = context.read<AuthCubit>();

    return Form(
      key: loginKey,
      child: BlocBuilder<AuthCubit, AuthState>(
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
              EmailField(
                authCubit: authCubit,
                isValidEmail: isValidEmail,
                autovalidateMode: autovalidateMode,
              ),
              PasswordField(
                authCubit: authCubit,
                isValidPassword: isValidPassword,
                autovalidateMode: autovalidateMode,
              ),
              ActionTextWidget(
                title:AppMessages.forgotPassMessageLogin ,
                routeName: Routes.forgotPassword,
              ),
              5.verticalSizedBox,
              SubmitButton(authCubit: authCubit, submit: loginUser, title: 'LOGIN',),
              110.verticalSizedBox,
              Text(
                AppMessages.loginSocialMessage,
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
    );
  }
}

