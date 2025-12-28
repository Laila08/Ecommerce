import 'package:flutter/material.dart';

import '../../../../../core/extensions/app_extentions.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/theme/app_text_styles.dart';
class OutlineButton extends StatelessWidget {
  final String title;
  final void Function()? onTap;
  const OutlineButton({super.key, required this.title,this.onTap});

  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: 14.vPading,
        decoration: BoxDecoration(
            borderRadius: 24.allBorderRadius,
          border: Border.all(
            color: AppColors.whiteColor,
            width: 1.5
          )

        ),
        child: Text(title,style:AppTextStyles.font15WhiteWeight500,).center(),
      ),
    );
  }
}
