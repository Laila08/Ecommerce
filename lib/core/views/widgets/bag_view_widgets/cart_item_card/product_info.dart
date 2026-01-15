import 'package:flutter/material.dart';

import '../../../../controllers/cart/cart_cubit.dart';
import '../../../../extensions/app_extentions.dart';
import '../../../../models/cart_model.dart';
import 'product_attributes.dart';
import 'product_name.dart';
import 'quantity_control.dart';

class ProductInfo extends StatelessWidget {
  final CartModel product;
  final CartCubit cartCubit;

  const ProductInfo({
    super.key,
    required this.product,
    required this.cartCubit,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProductName(name: product.productName),
        ProductAttributes(color: product.color, size: product.size),
        QuantityControl(product: product, cartCubit: cartCubit),
      ],
    ).onlyPadding(topPadding: 8, leftPadding: 15);
  }
}
