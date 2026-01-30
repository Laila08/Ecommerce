import 'package:ecommerceapp/core/controllers/auth/auth_cubit.dart';
import 'package:ecommerceapp/core/extensions/app_extentions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_messages.dart';
import 'email_field.dart';
import 'submit_button.dart';

class ForgotPasswordContent extends StatelessWidget {
  ForgotPasswordContent({super.key});
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future<void> submit(AuthCubit authCubit) async {
    final form = formKey.currentState;
    if (form == null) return;
    if (!form.validate()) {
      authCubit.enableAutoValidate();
      return;
    }
    final email = authCubit.emailController.text.trim();
    await authCubit.sendResetPasswordEmail(email);
    authCubit.clearForm();
  }

  @override
  Widget build(BuildContext context) {
    final AuthCubit authCubit = context.read<AuthCubit>();

    return FocusScope(
      node: authCubit.focusScopeNode,
      child: Form(
        key: formKey,
        child: BlocBuilder<AuthCubit, AuthState>(
          buildWhen: (previous, current) => current is AuthFormState,
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
                EmailField(
                  authCubit: authCubit,
                  isValidEmail: isValidEmail,
                  autovalidateMode: autovalidateMode,
                ),
                SubmitButton(
                  authCubit: authCubit,
                  submit: submit,
                  onSuccess: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          AppMessages.resetSuccessfully,
                        ),
                        backgroundColor: AppColors.successColor,
                      ),
                    );
                    authCubit.resetFormStatus();
                  },
                  title: AppMessages.send,
                ).onlyPadding(topPadding: 50),
              ],
            );
          },
        ),
      ),
    );
  }
}
