import 'package:ecommerceapp/core/utils/app_messages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../controllers/auth/auth_cubit.dart';
import '../../../extensions/app_extentions.dart';
import '../../../routes/routes.dart';
import 'action_text_widget.dart';
import 'email_field.dart';
import 'name_field.dart';
import 'password_field.dart';
import 'submit_button.dart';
import 'social_text.dart';

class SignUpFormWidget extends StatelessWidget {
  SignUpFormWidget({super.key});
  final GlobalKey<FormState> signupKey = GlobalKey<FormState>();

  Future<void> signupUser(AuthCubit authCubit) async {
    final form = signupKey.currentState;
    if (form == null || !form.validate()) {
      authCubit.enableAutoValidate();
      return;
    }
    await authCubit.signUp();
    authCubit.clearForm();
  }

  @override
  Widget build(BuildContext context) {
    final AuthCubit authCubit = context.read<AuthCubit>();
    return Form(
      key: signupKey,
      child: BlocBuilder<AuthCubit, AuthState>(
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
              NameField(
                authCubit: authCubit,
                isValidName: isValidName,
                autovalidateMode: autovalidateMode,
              ),
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
                title: AppMessages.alreadyHaveAccount,
                routeName: Routes.login,
              ),
              5.verticalSizedBox,
              SubmitButton(
                authCubit: authCubit,
                submit: signupUser,
                title: 'Sign Up',
              ),
              110.verticalSizedBox,
              SocialText(),
              SocialRow(),
            ],
          );
        },
      ),
    );
  }
}
