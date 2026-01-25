import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../controllers/cart/cart_cubit.dart';
import '../../../../extensions/app_extentions.dart';
import '../../../../models/cart_model.dart';
import '../../../../utils/app_colors.dart';
import 'product_image.dart';
import 'product_info.dart';
import 'product_price.dart';

class CartItemCard extends StatelessWidget {
  final double width;
  final CartModel product;
  const CartItemCard({
    super.key,
    required this.width,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 104,
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: 16.allBorderRadius,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ProductImage(productImage: product.productImage),
          Expanded(
            child: ProductInfo(product: product),
          ),
          ProductPrice(product: product),
        ],
      ),
    );
  }
}
