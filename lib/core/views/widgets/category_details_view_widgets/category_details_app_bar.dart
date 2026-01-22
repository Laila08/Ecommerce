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
      leading: const ArrowBackIcon(),
      actions: const [IconButton(onPressed: null, icon: Icon(Icons.search))],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
