import 'package:flutter/material.dart';

import '../../../../components/widgets/product_badge_widget.dart';
import '../../../../components/widgets/product_image_widget.dart';
import '../../../../components/widgets/rating_widget.dart';
import '../../../../controllers/favorite/favorite_cubit.dart';
import '../../../../extensions/app_extentions.dart';
import '../../../../models/product_model.dart';
import '../../../../theme/app_text_styles.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_messages.dart';

class ProductStack extends StatelessWidget {
  final ProductModel product;
  final double width;
  final int discount;
  final bool isInCart;
  final Map<String, bool> isNewOrDiscounted;
  final FavoriteCubit favoriteCubit;

  const ProductStack({
    super.key,
    required this.product,
    required this.width,
    required this.discount,
    required this.isInCart,
    required this.isNewOrDiscounted,
    required this.favoriteCubit,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
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
              child: Icon(Icons.shopping_bag, color: AppColors.whiteColor),
            ),
          ),
        Positioned(
          top: 10,
          right: 10,
          child: InkWell(
            onTap: () => favoriteCubit.toggleFavorite(product),
            child: Icon(Icons.close, color: AppColors.grayColor, size: 17),
          ),
        ),
      ],
    );
  }
}
