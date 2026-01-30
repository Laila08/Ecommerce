import 'package:ecommerceapp/core/utils/app_messages.dart';
import 'package:flutter/material.dart';

import '../../../components/widgets/app_text_field.dart';
import '../../../components/widgets/suffix_icon_widget.dart';
import '../../../controllers/auth/auth_cubit.dart';

class EmailField extends StatelessWidget {
  final AuthCubit authCubit;
  final bool? isValidEmail;
  final AutovalidateMode autovalidateMode;

  const EmailField({
    super.key,
    required this.authCubit,
    this.isValidEmail,
    required this.autovalidateMode,
  });

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      labelText: AppMessages.email,
      focusNodeType: authCubit.emailFocusNode,
      validator: (value) => authCubit.emailValidator(value ?? ""),
      controller: authCubit.emailController,
      autovalidateMode: autovalidateMode,
      suffixIcon: SuffixIconWidget.getSuffixIcon(isValidEmail),
      textInputAction: TextInputAction.next,
      onEditingCompleteFun: () {
        authCubit.validateEmail();
        authCubit.focusScopeNode.requestFocus(authCubit.passwordFocusNode);
      },
      onChangedFunction: (_) {
        authCubit.validateEmail();
      },

    );
  }
}
