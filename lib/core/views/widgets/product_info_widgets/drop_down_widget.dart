import 'package:ecommerceapp/core/extensions/app_extentions.dart';
import 'package:ecommerceapp/core/theme/app_text_styles.dart';
import 'package:ecommerceapp/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class DropDownWidget extends StatelessWidget {
  final void Function(String? value) onChanged;
  final List<String> items;
  final String hint;

  const DropDownWidget({
    super.key,
    required this.onChanged,
    required this.items,
    required this.hint,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      initialValue: null,
      icon: const Icon(Icons.keyboard_arrow_down, color: Colors.black),
      hint: FittedBox(child: Text(hint)),
      focusColor: AppColors.grayColor,
      dropdownColor: AppColors.backGroundColor,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: 16.allBorderRadius,
          borderSide: BorderSide(color: AppColors.grayColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: 16.allBorderRadius,
          borderSide: BorderSide(color: AppColors.primaryColor),
        ),
      ),
      style: AppTextStyles.font14blackWeight500,
      isExpanded: true,
      items: items.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value, style: AppTextStyles.font14blackWeight500),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}
