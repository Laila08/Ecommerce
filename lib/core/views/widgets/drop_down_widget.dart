import 'package:ecommerceapp/core/extensions/app_extentions.dart';
import 'package:ecommerceapp/core/utils/app_colors.dart';
import'package:flutter/material.dart';
    class DropDownWidget extends StatelessWidget {
      final void Function(String? value) onChanged;
      final List<String> items;
      final String hint;
      final TextStyle textStyle;
      const DropDownWidget({super.key, required this.onChanged, required this.items, required this.hint, required this.textStyle});

      @override
      Widget build(BuildContext context) {
        return DropdownButtonFormField<String>(
          icon: const Icon(Icons.keyboard_arrow_down,color:Colors.black,),
            initialValue: null,
            hint: FittedBox(child: Text(hint)),
            focusColor: AppColors.grayColor,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: 16.allBorderRadius,
                borderSide: BorderSide(
                  color: AppColors.grayColor
                )
              )
            ),
            style: textStyle,
            isExpanded: true,
            items:items
                .map<DropdownMenuItem<String>>((String value){
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged:onChanged
        );
      }
}
    