import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../components/widgets/favorite_icon_widget.dart';
import '../../../../components/widgets/product_badge_widget.dart';
import '../../../../components/widgets/product_image_widget.dart';
import '../../../../components/widgets/rating_widget.dart';
import '../../../../controllers/favorite/favorite_cubit.dart';
import '../../../../extensions/app_extentions.dart';
import '../../../../models/product_model.dart';
import '../../../../theme/app_text_styles.dart';
import '../../../../utils/app_colors.dart';

class ProductImageSection extends StatelessWidget {
  final ProductModel product;
  final double width;

  const ProductImageSection({
    super.key,
    required this.product,
    required this.width,
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
        if (product.productDiscount != 0)
          ProductBadgeWidget(
            title: "-${product.productDiscount}%",
            color: AppColors.primaryColor,
            textStyle: AppTextStyles.font11WhiteWeight400,
          ),
        Positioned(
          bottom: 5,
          right: 0,
          child: BlocBuilder<FavoriteCubit, FavoriteState>(
            builder: (context, state) {
              final isFavorite = (state is FavoriteSuccess)
                  ? state.favoriteProducts.any(
                      (p) => p.productId == product.productId,
                    )
                  : false;

              return FavoriteIconWidget(
                isFavorite: isFavorite,
                onTap: () =>
                    context.read<FavoriteCubit>().toggleFavorite(product),
              );
            },
          ),
        ),
      ],
    );
  }
}
