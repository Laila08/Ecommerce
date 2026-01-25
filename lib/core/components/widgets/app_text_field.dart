import 'package:flutter/material.dart';

import '../../extensions/app_extentions.dart';
import '../../utils/app_colors.dart';
import '../../theme/app_text_styles.dart';

class AppTextField extends StatelessWidget {
  final VoidCallback? onTap;
  final bool readOnly;
  final String labelText;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final Function validator;
  final Widget? suffixIcon;
  final FocusNode? focusNodeType;
  final VoidCallback? onEditingCompleteFun;
  final TextInputAction textInputAction;
  final ValueChanged<String> onChangedFunction;
  final TextStyle hintStyle;
  AutovalidateMode? autovalidateMode;

  AppTextField({
    super.key,
    required this.labelText,
    this.keyboardType,
    this.autovalidateMode,
    this.controller,
    required this.validator,
    this.suffixIcon,
    this.focusNodeType,
    this.onEditingCompleteFun,
    required this.textInputAction,
    required this.onChangedFunction,
    this.hintStyle = AppTextStyles.font14GrayWeight500,
    this.onTap,
    this.readOnly = false,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 1),
            blurRadius: 8,
            spreadRadius: 0,
            color: AppColors.whiteColor.withValues(alpha: 0.05),
          ),
        ],
      ),
      child: TextFormField(
        readOnly: readOnly,
        onTap: onTap,
        controller: controller,
        focusNode: focusNodeType,
        onEditingComplete: () {
          if (onEditingCompleteFun != null) {
            onEditingCompleteFun!();
          }
        },
        style: AppTextStyles.font14blackWeight500,
        cursorColor: AppColors.blackColor,
        keyboardType: keyboardType,
        onChanged: onChangedFunction,
        autovalidateMode: autovalidateMode,
        validator: (x) => validator(x),
        textInputAction: textInputAction,
        decoration: InputDecoration(
          contentPadding: 20.allPading,
          fillColor: AppColors.whiteColor,
          filled: true,
          hintText: labelText,
          hintStyle: hintStyle,
          suffixIcon: suffixIcon,
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          floatingLabelStyle: TextStyle(backgroundColor: AppColors.whiteColor),
          floatingLabelAlignment: FloatingLabelAlignment.start,
          border: OutlineInputBorder(
            borderRadius: 4.allBorderRadius,
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: 4.allBorderRadius,
            borderSide: BorderSide.none,
          ),

          focusedBorder: OutlineInputBorder(
            borderRadius: 4.allBorderRadius,
            borderSide: BorderSide(color: Colors.transparent),
          ),

          errorBorder: OutlineInputBorder(
            borderRadius: 4.allBorderRadius,
            borderSide: BorderSide(color: AppColors.errorColor, width: 1),
          ),

          focusedErrorBorder: OutlineInputBorder(
            borderRadius: 4.allBorderRadius,
            borderSide: BorderSide(color: AppColors.errorColor, width: 1),
          ),
        ),
      ),
    );
  }
}
