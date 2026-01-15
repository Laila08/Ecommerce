import 'package:ecommerceapp/core/models/cart_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../controllers/cart/cart_cubit.dart';
import '../../../../controllers/favorite/favorite_cubit.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/product_option.dart';

class CartPopupMenu  extends StatelessWidget {
  final CartModel product;
  const CartPopupMenu({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return  PopupMenuButton<ProductOption>(
      icon: const Icon(Icons.more_vert, color: AppColors.grayColor),
      color: AppColors.whiteColor,
      constraints: const BoxConstraints(
        maxWidth: 170,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      onSelected: (option) {
        switch (option) {
          case ProductOption.addToFavorites:
            final favoriteCubit = context.read<FavoriteCubit>();
            favoriteCubit.addToFavorite(product);
            break;
          case ProductOption.delete:
            final cartCubit = context.read<CartCubit>();
            cartCubit.removeFromCarts(product);
            break;
        }
      },
      itemBuilder: (context) => [
        PopupMenuItem<ProductOption>(
          value: ProductOption.addToFavorites,
          child: Center(child: Text("Add to favorites")),
        ),
        PopupMenuDivider(
          height: 1,
          thickness: 1,
          color: AppColors.grayColor.withValues(alpha: 0.10),
        ),
        const PopupMenuItem<ProductOption>(
          value: ProductOption.delete,
          child: Center(child: Text("Delete from the list")),
        ),
      ],
    );
  }
}
