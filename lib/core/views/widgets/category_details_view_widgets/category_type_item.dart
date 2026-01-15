import 'package:flutter/material.dart';

import '../../../extensions/app_extentions.dart';
import '../../../theme/app_text_styles.dart';
import '../../../utils/app_colors.dart';

class CategoryTypeItem extends StatelessWidget {
  final String type;
  final bool isSelected;
  final VoidCallback onTap;
  final VoidCallback onClear;
  final bool isLast;

  const CategoryTypeItem({
    super.key,
    required this.type,
    required this.isSelected,
    required this.onTap,
    required this.onClear,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 30,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.whiteColor : AppColors.blackColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? Colors.black : Colors.transparent,
            width: 1.5,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              type,
              style: isSelected
                  ? AppTextStyles.font14blackWeight500
                  : AppTextStyles.font14WhiteWeight500,
            ),
            if (isSelected) ...[
              const SizedBox(width: 6),
              InkWell(
                onTap: onClear,
                child: const Icon(
                  Icons.close,
                  size: 16,
                  color: AppColors.errorColor,
                ),
              ),
            ],
          ],
        ),
      ).onlyPadding(leftPadding: 16),
    ).onlyPadding(rightPadding: isLast ? 16 : 0);
  }
}
