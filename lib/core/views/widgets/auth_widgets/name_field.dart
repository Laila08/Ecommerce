import 'package:flutter/material.dart';

import '../../../components/widgets/app_text_field.dart';
import '../../../components/widgets/suffix_icon_widget.dart';
import '../../../controllers/auth/auth_cubit.dart';

class NameField extends StatelessWidget {
  final AuthCubit authCubit;
  final bool? isValidName;
  final AutovalidateMode autovalidateMode;

  const NameField({super.key, required this.authCubit, this.isValidName, required this.autovalidateMode});

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      suffixIcon: SuffixIconWidget.getSuffixIcon(isValidName),
      labelText: "Name",
      controller: authCubit.nameController,
      focusNodeType: authCubit.nameFocusNode,
      validator: (value) => authCubit.nameValidator(value ?? ""),
      textInputAction: TextInputAction.next,
      autovalidateMode: autovalidateMode,
      onChangedFunction: (_) => authCubit.validateName(),
      onEditingCompleteFun: () => FocusScope.of(context).requestFocus(authCubit.emailFocusNode),
    );
  }
}