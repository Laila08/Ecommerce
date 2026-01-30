import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../controllers/favorite/favorite_cubit.dart';
import '../../../../extensions/app_extentions.dart';
import '../../../../models/product_model.dart';
import '../../../../utils/app_colors.dart';
import 'in_cart_indicator.dart';
import 'product_badge.dart';
import 'product_item_card.dart';

class FavoriteItemWidget extends StatelessWidget {
  final ProductModel product;

  const FavoriteItemWidget({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final favoriteCubit = BlocProvider.of<FavoriteCubit>(context);
    final width = context.width;

    return Stack(
      children: [
        Column(
          children: [
            ProductItemCard(
              width: width,
              product: product,
              favoriteCubit: favoriteCubit,
            ),
            Container(color: AppColors.backGroundColor, height: 20),
          ],
        ),
        ProductBadge(product: product),
        InCartIndicator(product: product),
      ],
    ).onlyPadding(topPadding: 15, leftPadding: 16, rightPadding: 16);
  }
}
