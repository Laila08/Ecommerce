import 'package:ecommerceapp/core/components/widgets/favorite_icon_widget.dart';
import 'package:ecommerceapp/core/extensions/app_extentions.dart';
import 'package:ecommerceapp/core/routes/routes.dart';
import 'package:ecommerceapp/core/theme/app_text_styles.dart';
import 'package:ecommerceapp/core/utils/products_list_type.dart';
import 'package:ecommerceapp/core/views/widgets/product_image_widget.dart';
import 'package:ecommerceapp/core/views/widgets/rating_widget.dart';
import 'package:ecommerceapp/core/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../controllers/favorite/favorite_cubit.dart';
import 'product_badge_widget.dart';
import 'product_info_widget.dart';

class ProductItem extends StatelessWidget {
  final ProductModel product;
  final Color color;
  final ProductsListType listType;

  const ProductItem({super.key, required this.product, required this.color, required this.listType,});

  @override
  Widget build(BuildContext context) {
    final favoriteCubit = BlocProvider.of<FavoriteCubit>(context);
    String badgeTitle ="";

    if (listType == ProductsListType.sale) {
      badgeTitle = '-${product.productDiscount}%';
    } else if (listType == ProductsListType.New) {
      badgeTitle = 'NEW';
    }

    return InkWell(
      onTap:(){
       context.pushNamed(Routes.productinfo,arguments: product.productId,);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProductImageWidget(
                    image:
                    product.productImage,
                    width: 148,
                    height: 184,
                  ),
                  RatingWidget(product: product).onlyPadding(bottomPadding: 4, topPadding: 4),
                ],
              ),
              ProductBadgeWidget(
                title: badgeTitle,
                color: color,
                textStyle: AppTextStyles.font11WhiteWeight400,
              ),
              Positioned(bottom: 5, right: 0, child:
              BlocBuilder<FavoriteCubit, FavoriteState>(
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
              ),),
            ],
          ),
          ProductInfoWidget(
            name: product.productCategory,
            type: product.productName,
            price: product.productPrice, disCount: product.productDiscount??0,
          ),
        ],
      ).onlyPadding(topPadding: 25, leftPadding: 16),
    );
  }
}
