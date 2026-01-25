import 'package:flutter/material.dart';
import '../../../theme/app_text_styles.dart';
import '../../../utils/app_colors.dart';

class CheckoutAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CheckoutAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(Icons.arrow_back_ios),
      ),

      backgroundColor: AppColors.whiteColor,
      centerTitle: true,
      title: Text("Checkout", style: AppTextStyles.font18BlackWeight400),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
