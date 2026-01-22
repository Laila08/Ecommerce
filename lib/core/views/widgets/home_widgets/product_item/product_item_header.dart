import 'package:flutter/material.dart';

import '../../../../extensions/app_extentions.dart';
import '../../../../models/product_model.dart';
import '../../../../theme/app_text_styles.dart';
import '../../../../utils/products_list_type.dart';
import '../../../../components/widgets/product_badge_widget.dart';
import '../../../../components/widgets/product_image_widget.dart';
import '../../../../components/widgets/rating_widget.dart';
import 'product_favorite_button.dart';

class ProductItemHeader extends StatelessWidget {
  final ProductModel product;
  final Color color;
  final ProductsListType listType;

  const ProductItemHeader({
    super.key,
    required this.product,
    required this.color,
    required this.listType,
  });

  String _badgeTitle() {
    switch (listType) {
      case ProductsListType.sale:
        return '-${product.productDiscount}%';
      case ProductsListType.New:
        return 'NEW';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProductImageWidget(
              image: product.productImage,
              width: 148,
              height: 184,
            ),
            RatingWidget(
              product: product,
            ).onlyPadding(bottomPadding: 4, topPadding: 4),
          ],
        ),
        if (_badgeTitle().isNotEmpty)
          ProductBadgeWidget(
            title: _badgeTitle(),
            color: color,
            textStyle: AppTextStyles.font11WhiteWeight400,
          ),
        Positioned(
          bottom: 5,
          right: 0,
          child: ProductFavoriteButton(product: product),
        ),
      ],
    );
  }
}
