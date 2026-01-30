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

  final GlobalKey<FormState> _signupKey = GlobalKey<FormState>();

  Future<void> _signupUser(AuthCubit authCubit) async {
    final form = _signupKey.currentState;
    if (form == null || !form.validate()) {
      authCubit.enableAutoValidate();
      return;
    }
    await authCubit.signUp();
  }

  @override
  Widget build(BuildContext context) {
    final authCubit = context.read<AuthCubit>();
    return FocusScope(
      node: authCubit.focusScopeNode,
      child: Form(
        key: _signupKey,
        child: BlocBuilder<AuthCubit, AuthState>(
          buildWhen: (previous, current) =>
              current is AuthFormState ,
          builder: (_, state) {
            final formState = state is AuthFormState ? state : null;
            return Column(
              spacing: 12,
              children: [
                NameField(
                  authCubit: authCubit,
                  isValidName: formState?.isValidName,
                  autovalidateMode:
                      formState?.autovalidateMode ?? AutovalidateMode.disabled,
                ),
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
                  title: AppMessages.alreadyHaveAccount,
                  routeName: Routes.login,
                ),
                5.verticalSizedBox,
                SubmitButton(
                  authCubit: authCubit,
                  submit: _signupUser,
                  title: AppMessages.signUpTitle,
                ),
                110.verticalSizedBox,
                const SocialText(),
                const SocialRow(),
              ],
            );
          },
        ),
      ),
    );
  }
}
