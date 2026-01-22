import 'package:flutter/material.dart';

import '../../../components/widgets/arrow_back_icon.dart';
import '../../../extensions/app_extentions.dart';
import '../../../models/product_model.dart';
import '../../../theme/app_text_styles.dart';
import '../../../utils/app_colors.dart';

class ProductInfoAppBar extends StatelessWidget implements PreferredSizeWidget {
  final ProductModel product;

  const ProductInfoAppBar({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        product.productName,
        style: AppTextStyles.font18BlackWeight400,
      ),
      centerTitle: true,
      leading: ArrowBackIcon().onlyPadding(leftPadding: 16),
      actions: [
        Icon(
          Icons.share,
          color: AppColors.blackColor,
        ).onlyPadding(rightPadding: 16),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
