import 'package:ecommerceapp/core/extensions/app_extentions.dart';
import 'package:ecommerceapp/core/theme/app_text_styles.dart';
import 'package:ecommerceapp/core/components/widgets/product_image_widget.dart';
import 'package:ecommerceapp/core/components/widgets/rating_widget.dart';
import 'package:ecommerceapp/core/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../controllers/cart/cart_cubit.dart';
import '../../../controllers/favorite/favorite_cubit.dart';
import '../../../controllers/home/home_cubit.dart';
import '../../../utils/app_colors.dart';
import '../../../components/widgets/product_badge_widget.dart';
import '../../../utils/app_messages.dart';
import 'build_product_info.dart';

class ProFavGridItem extends StatelessWidget {
  final ProductModel product;

  const ProFavGridItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final favoriteCubit = context.read<FavoriteCubit>();
    final width = (context.width - 16 * 2 - 16) / 2;
    final discount = product.productDiscount ?? 0;
    final finalPrice = product.productPrice * (1 - discount / 100);

    final isInCart = context.select(
      (CartCubit c) =>
          c.state is CartISuccess &&
          (c.state as CartISuccess).cartProducts.any(
            (item) => item.productId == product.productId,
          ),
    );

    final isNewOrDiscounted = context.select((HomeCubit c) {
      bool isDiscounted = false;
      bool isNew = false;
      final state = c.state;
      if (state is HomeSuccess) {
        isDiscounted = state.salesProducts.any(
          (p) =>
              p.productId == product.productId && (p.productDiscount ?? 0) > 0,
        );
        if (!isDiscounted) {
          isNew = state.newProducts.any(
            (p) => p.productId == product.productId,
          );
        }
      }
      return {'isDiscounted': isDiscounted, 'isNew': isNew};
    });

    return InkWell(
      onTap: () {},
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProductImageWidget(
                    image: product.productImage,
                    width: width,
                    height: 170,
                  ),
                  RatingWidget(product: product).onlyPadding(topPadding: 5),
                ],
              ),
              if (discount > 0)
                ProductBadgeWidget(
                  title: "-$discount${AppMessages.percent}",
                  color: AppColors.primaryColor,
                  textStyle: AppTextStyles.font11WhiteWeight400,
                ),
              if (isNewOrDiscounted['isDiscounted']!)
                ProductBadgeWidget(
                  title: "$discount${AppMessages.percent}",
                  color: AppColors.primaryColor,
                  textStyle: AppTextStyles.font11WhiteWeight400,
                )
              else if (isNewOrDiscounted['isNew']!)
                ProductBadgeWidget(
                  title: AppMessages.newText,
                  color: AppColors.blackColor,
                  textStyle: AppTextStyles.font11WhiteWeight400,
                ),
              if (isInCart)
                Positioned(
                  bottom: 3,
                  right: 0,
                  child: CircleAvatar(
                    radius: 18,
                    backgroundColor: AppColors.primaryColor,
                    child: Icon(
                      Icons.shopping_bag,
                      color: AppColors.whiteColor,
                    ),
                  ),
                ),
              Positioned(
                top: 10,
                right: 10,
                child: InkWell(
                  onTap: () => favoriteCubit.toggleFavorite(product),
                  child: Icon(
                    Icons.close,
                    color: AppColors.grayColor,
                    size: 17,
                  ),
                ),
              ),
            ],
          ),
          BuildProductInfo(
            finalPrice: finalPrice,
            discount: discount,
            product: product,
          ),
        ],
      ),
    );
  }
}
