import 'package:ecommerceapp/core/utils/app_messages.dart';
import 'package:flutter/material.dart';

import '../../../components/widgets/app_text_field.dart';
import '../../../components/widgets/suffix_icon_widget.dart';
import '../../../controllers/auth/auth_cubit.dart';

class NameField extends StatelessWidget {
  final AuthCubit authCubit;
  final bool? isValidName;
  final AutovalidateMode autovalidateMode;

  const NameField({
    super.key,
    required this.authCubit,
    this.isValidName,
    required this.autovalidateMode,
  });

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      suffixIcon: SuffixIconWidget.getSuffixIcon(isValidName),
      labelText: AppMessages.name,
      controller: authCubit.nameController,
      focusNodeType: authCubit.nameFocusNode,
      validator: (value) => authCubit.nameValidator(value ?? ""),
      textInputAction: TextInputAction.next,
      autovalidateMode: autovalidateMode,
      onEditingCompleteFun: ()  {
        authCubit.validateName();
        authCubit.focusScopeNode.requestFocus(authCubit.emailFocusNode);
      },
      onChangedFunction: (_) {
        authCubit.validateName();
      },

    );
  }
}
