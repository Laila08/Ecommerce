import 'package:ecommerceapp/core/extensions/app_extentions.dart';
import 'package:ecommerceapp/core/models/product_model.dart';
import 'package:flutter/material.dart';
import '../category_details_view_widgets/product_cat_item/product_card.dart';
import '../category_details_view_widgets/product_cat_item/product_favorite_button.dart';

class ProductCatItem extends StatelessWidget {
  final ProductModel product;

  const ProductCatItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final width = context.width;

    return Stack(
      children: [
        Column(
          children: [ProductCard(width: width, product: product)],
        ),
        Positioned(
          bottom: 5,
          right: 0,
          child: ProductFavoriteButton(product: product),
        ),
      ],
    ).onlyPadding(topPadding: 15, leftPadding: 16, rightPadding: 16);
  }
}
