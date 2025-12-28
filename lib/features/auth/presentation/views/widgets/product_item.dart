import 'package:ecommerceapp/core/components/widgets/favorite_icon_widget.dart';
import 'package:ecommerceapp/core/extensions/app_extentions.dart';
import 'package:ecommerceapp/core/routes/routes.dart';
import 'package:ecommerceapp/core/theme/app_text_styles.dart';
import 'package:ecommerceapp/core/utils/products_list_type.dart';
import 'package:ecommerceapp/features/auth/presentation/views/widgets/product_image_widget.dart';
import 'package:ecommerceapp/features/auth/presentation/views/widgets/rating_widget.dart';
import 'package:ecommerceapp/product_model.dart';
import 'package:flutter/material.dart';

import 'product_badge_widget.dart';
import 'product_info_widget.dart';

class ProductItem extends StatelessWidget {
  final ProductModel product;
  final Color color;
  final ProductsListType listType;

  const ProductItem({super.key, required this.product, required this.color, required this.listType,});

  @override
  Widget build(BuildContext context) {

    String badgeTitle ="";
    if (listType == ProductsListType.sale) {
      badgeTitle = '-${product.productDiscount}%';
    } else if (listType == ProductsListType.newProducts) {
      badgeTitle = 'NEW';
    }
    return InkWell(
      onTap:(){
        context.pushNamed(Routes.productinfo,arguments: product);
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
              Positioned(bottom: 5, right: 0, child: FavoriteIconWidget()),
            ],
          ),
          ProductInfoWidget(
            name: product.productName,
            type: product.productCategory,
            price: product.productPrice, disCount: product.productDiscount??0,
          ),
        ],
      ).onlyPadding(topPadding: 25, leftPadding: 16),
    );
  }
}
