import 'package:flutter/material.dart';
import '../../../components/widgets/arrow_back_icon.dart';
import '../../../utils/app_colors.dart';

class CategoryDetailsAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const CategoryDetailsAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.whiteColor,
      elevation: 0,
      leading: const ArrowBackIcon(),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.search),
          color: AppColors.blackColor,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
