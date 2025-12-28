import 'package:flutter/material.dart';

import '../../extensions/app_extentions.dart';
import '../../utils/app_colors.dart';
class FavoriteIconWidget extends StatelessWidget {
  const FavoriteIconWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: 18.allBorderRadius,
        boxShadow: [
          BoxShadow(
            spreadRadius: 0,
            blurRadius: 4,
            offset: Offset(0, 4),
            color: AppColors.grayColor.withValues(alpha: 0.8),
          ),
        ],
      ),
      child: Icon(Icons.favorite_border, color: AppColors.grayColor, size: 18),
    );
  }
}
