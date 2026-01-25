import 'package:ecommerceapp/core/controllers/cart/cart_cubit.dart';
import 'package:flutter/material.dart';
import '../../../../extensions/app_extentions.dart';
import '../../../../models/cart_model.dart';
import '../../../../theme/app_text_styles.dart';
import 'popup_menu_button.dart';

class ProductPrice extends StatelessWidget {
  final CartModel product;
  const ProductPrice({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        CartPopupMenu(product: product),
        Text(
          "${product.productPrice * product.quantity}\$",
          style: AppTextStyles.font14blackWeight500,
        ).onlyPadding(topPadding: 15, rightPadding: 20),
      ],
    ).onlyPadding(topPadding: 5);
  }
}
