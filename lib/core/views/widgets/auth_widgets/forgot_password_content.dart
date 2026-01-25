import 'package:ecommerceapp/core/controllers/auth/auth_cubit.dart';
import 'package:ecommerceapp/core/extensions/app_extentions.dart';
import 'package:ecommerceapp/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../utils/app_messages.dart';
import 'email_field.dart';
import 'submit_button.dart';

class ForgotPasswordContent extends StatelessWidget {
  ForgotPasswordContent({super.key});
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future<void> submit(AuthCubit authCubit) async {
    final form = formKey.currentState;
    if (form == null || !form.validate()) {
      authCubit.enableAutoValidate();
      return;
    }
    await authCubit.sendResetPasswordEmail(
      authCubit.emailController.text.trim(),
    );
    authCubit.clearForm();
  }

  @override
  Widget build(BuildContext context) {
    final AuthCubit authCubit = context.read<AuthCubit>();

    return Form(
      key: formKey,
      child: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          bool? isValidEmail;
          AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

          if (state is AuthFormState) {
            isValidEmail = state.isValidEmail;
            autovalidateMode = state.autovalidateMode;
          }
          return Column(
            spacing: 12,
            children: [
              Text(
                AppMessages.forgotPassMess,
                style: AppTextStyles.font14blackWeight500,
              ).onlyPadding(bottomPadding: 10),
              EmailField(
                authCubit: authCubit,
                isValidEmail: isValidEmail,
                autovalidateMode: autovalidateMode,
              ),
              SubmitButton(
                authCubit: authCubit,
                submit: submit,
                title: 'SEND',
              ).onlyPadding(topPadding: 50),
            ],
          );
        },
      ),
    );
  }
}
