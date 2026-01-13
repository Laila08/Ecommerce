import 'package:flutter/material.dart';

import '../../extensions/app_extentions.dart';
import '../../utils/app_colors.dart';
class FavoriteIconWidget extends StatelessWidget {
  final VoidCallback onTap;
  final bool isFavorite;
  const FavoriteIconWidget({super.key, required this.onTap, required this.isFavorite});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      child: Container(
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
              color: AppColors.grayColor.withValues(alpha: 0.08),
            ),
          ],
        ),
        child: Icon(
          isFavorite ? Icons.favorite : Icons.favorite_border,
          color: isFavorite ? AppColors.primaryColor : AppColors.grayColor,
          size: 18,
        ),
      ),
    );
  }
}
