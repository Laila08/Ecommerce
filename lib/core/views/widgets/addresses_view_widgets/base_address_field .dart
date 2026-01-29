import 'package:flutter/material.dart';
import '../../../components/widgets/app_text_field.dart';
import '../../../controllers/checkout/shipping_address/shipping_address_cubit.dart';
import '../../../theme/app_text_styles.dart';

class AddressFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String Function(String?)? validator;
  final TextInputAction textInputAction;
  final void Function(String)? onChanged;
  final TextStyle? hintStyle;
  final bool readOnly;
  final VoidCallback? onTap;
  final Widget? suffixIcon;

  const AddressFieldWidget({
    super.key,
    required this.controller,
    required this.labelText,
    this.validator,
    this.textInputAction = TextInputAction.next,
    this.onChanged,
    this.hintStyle,
    this.readOnly = false,
    this.onTap,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      controller: controller,
      labelText: labelText,
      validator: validator,
      textInputAction: textInputAction,
      hintStyle: hintStyle ?? AppTextStyles.font14GrayWeight500,
      readOnly: readOnly,
      onChangedFunction: onChanged ?? (x) {},
      onTap: onTap,
      suffixIcon: suffixIcon,
    );
  }
}
