import 'package:ecommerceapp/core/controllers/favorite/favorite_cubit.dart';
import 'package:ecommerceapp/core/extensions/app_extentions.dart';
import 'package:ecommerceapp/core/theme/app_text_styles.dart';
import 'package:ecommerceapp/core/utils/app_colors.dart';
import 'package:ecommerceapp/core/models/product_model.dart';
import 'package:ecommerceapp/core/views/widgets/rating_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../components/widgets/favorite_icon_widget.dart';

class ProductCatItem extends StatelessWidget {
  final ProductModel product;

  const ProductCatItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final favoriteCubit = BlocProvider.of<FavoriteCubit>(context);
    final width = context.width;
    return Stack(
      children: [
        Column(
          children: [
            _itemCard(width, product),
          ],
        ),
        Positioned(
          bottom: 5,
          right: 0,
          child:   BlocBuilder<FavoriteCubit, FavoriteState>(
            builder: (context, favState) {
              bool isFav = false;
              if (favState is FavoriteSuccess) {
                isFav = favState.favoriteProducts.any((p) => p.productId == product.productId);
              }
              return FavoriteIconWidget(
                isFavorite: isFav,
                onTap: () {
                  favoriteCubit.toggleFavorite(product);
                },
              );
            },
          ),
        ),
      ],
    ).onlyPadding(topPadding: 15, leftPadding: 16, rightPadding: 16);
  }
}

Widget _itemCard(double width, ProductModel product) {
  return BlocBuilder<FavoriteCubit, FavoriteState>(
    builder: (context, state) {
      return Container(
        width: width,
        height: 104,
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: 16.allBorderRadius,
          boxShadow: [
            BoxShadow(
              color: AppColors.blackColor.withValues(alpha: 0.08),
              blurRadius: 25,
              spreadRadius: 0,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ClipRRect(
              borderRadius: BorderRadiusGeometry.only(
                topLeft: Radius.circular(16),
                bottomLeft: Radius.circular(16),
              ),
              child: Image.asset(
                product.productImage,
                width: 104,
                height: 104,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.catType,
                    style: AppTextStyles.font16BlackWeight400,
                  ),
                  Text(
                    product.productName,
                    style: AppTextStyles.font11GrayWeight400,
                  ),
                  RatingWidget(
                    product: product,
                  ).onlyPadding(topPadding: 7, bottomPadding: 4),
                  Text(
                    "${product.productPrice}\$",
                    style: AppTextStyles.font14blackWeight500,
                  ),
                ],
              ).onlyPadding(topPadding: 10, leftPadding: 10),
            ),
          ],
        ),
      ).onlyPadding(bottomPadding: 16);
    },
  );
}
