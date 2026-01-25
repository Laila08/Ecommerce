import 'package:flutter/material.dart';

import '../../../components/widgets/app_text_field.dart';
import '../../../components/widgets/suffix_icon_widget.dart';
import '../../../controllers/auth/auth_cubit.dart';

class PasswordField extends StatelessWidget {
  final AuthCubit authCubit;
  final bool? isValidPassword;
  final AutovalidateMode autovalidateMode;

  const PasswordField({super.key, required this.authCubit, this.isValidPassword, required this.autovalidateMode});

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      onChangedFunction: (_) => authCubit.validatePassword(),
      suffixIcon: SuffixIconWidget.getSuffixIcon(isValidPassword),
      labelText: "Password",
      controller: authCubit.passwordController,
      focusNodeType: authCubit.passwordFocusNode,
      validator: (value) => authCubit.passwordValidator(value ?? ""),
      textInputAction: TextInputAction.done,
      autovalidateMode: autovalidateMode,
    );
  }
}
