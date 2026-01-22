import 'package:ecommerceapp/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class SuffixIconWidget{
 static Widget? getSuffixIcon(bool? isValid) {
   if (isValid == null) return null;
   return isValid
       ? Icon(Icons.check, color: AppColors.successColor)
       : Icon(Icons.close, color: AppColors.errorColor);
 }

}