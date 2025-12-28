import 'package:ecommerceapp/core/extensions/app_extentions.dart';
import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';
class ArrowBackIcon extends StatelessWidget {
  const ArrowBackIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(onPressed:(){
      context.pop();
    }, icon: const Icon(Icons.arrow_back_ios,color: AppColors.blackColor,));
  }
}
