import 'package:flutter/material.dart';

import '../../../../components/widgets/rating_widget.dart';
import '../../../../controllers/favorite/favorite_cubit.dart';
import '../../../../extensions/app_extentions.dart';
import '../../../../models/product_model.dart';
import '../../../../routes/routes.dart';
import '../../../../theme/app_text_styles.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_messages.dart';
import 'favorite_close_button.dart';

class ProductItemCard extends StatelessWidget {
  final double width;
  final ProductModel product;
  final FavoriteCubit favoriteCubit;

  const ProductItemCard({
    super.key,
    required this.width,
    required this.product,
    required this.favoriteCubit,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.pushNamed(Routes.productinfo, arguments: product.productId),
      child: Container(
        width: width,
        height: 104,
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: 16.allBorderRadius,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
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
                  Text(product.productName, style: AppTextStyles.font16BlackWeight400),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(text: AppMessages.color, style: AppTextStyles.font11GrayWeight400),
                        TextSpan(text: "_   ", style: AppTextStyles.font11BlackWeight400),
                        TextSpan(text: AppMessages.size, style: AppTextStyles.font11GrayWeight400),
                        TextSpan(text: "_", style: AppTextStyles.font11BlackWeight400),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("${product.productPrice}${AppMessages.dollar}", style: AppTextStyles.font14blackWeight500),
                      RatingWidget(product: product),
                    ],
                  ).onlyPadding(topPadding: 20, rightPadding: 15),
                ],
              ).onlyPadding(topPadding: 16, leftPadding: 7),
            ),
            FavoriteCloseButton(product: product, favoriteCubit: favoriteCubit),
          ],
        ),
      ),
    );
  }
}
