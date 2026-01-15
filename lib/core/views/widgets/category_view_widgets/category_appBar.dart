import 'package:flutter/material.dart';

import '../../../extensions/app_extentions.dart';
import '../../../theme/app_text_styles.dart';
import '../../../utils/app_colors.dart';

class CategoryAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const CategoryAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        "Categories",
        style: AppTextStyles.font18BlackWeight400,
      ),
      backgroundColor: AppColors.whiteColor,
      centerTitle: true,
      actions: [
        Icon(
          Icons.search,
          color: AppColors.blackColor,
        ).onlyPadding(rightPadding: 16),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
