import 'package:flutter/material.dart';

import '../../../../controllers/favorite/favorite_cubit.dart';
import '../../../../extensions/app_extentions.dart';
import '../../../../models/product_model.dart';
import '../../../../utils/app_colors.dart';

class FavoriteCloseButton extends StatelessWidget {
  final ProductModel product;
  final FavoriteCubit favoriteCubit;

  const FavoriteCloseButton({
    super.key,
    required this.product,
    required this.favoriteCubit,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => favoriteCubit.toggleFavorite(product),
      child: Icon(Icons.close, color: AppColors.grayColor, size: 17)
          .onlyPadding(rightPadding: 16, topPadding: 16),
    );
  }
}
