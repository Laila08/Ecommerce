import 'package:flutter/material.dart';

import '../../../components/widgets/app_text_field.dart';
import '../../../theme/app_text_styles.dart';

class BaseAddressField extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final TextInputAction textInputAction;
  final String? Function(String?) validator;
  final bool? readOnly;
  final VoidCallback? onTap;
  final void Function(String)? onChanged;
  final Widget? suffixIcon;

  const BaseAddressField({
    super.key,
    required this.labelText,
    required this.controller,
    required this.validator,
    this.onChanged,
    required this.textInputAction,
    this.readOnly,
    this.onTap,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      labelText: labelText,
      controller: controller,
      readOnly: readOnly?? false,
      validator: validator,
      textInputAction: textInputAction,
      onTap: onTap,
      suffixIcon: suffixIcon,
      hintStyle: AppTextStyles.font14GrayWeight500,
    );
  }
}
