import 'package:flutter/material.dart';

import '../../../extensions/app_extentions.dart';
import '../../../models/product_model.dart';
import '../../../routes/routes.dart';
import '../../../utils/products_list_type.dart';
import '../product_info_widgets/product_info_widget.dart';
import 'product_item/product_item_header.dart';

class ProductItem extends StatelessWidget {
  final ProductModel product;
  final Color color;
  final ProductsListType listType;

  const ProductItem({
    super.key,
    required this.product,
    required this.color,
    required this.listType,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.pushNamed(Routes.productinfo, arguments: product.productId);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProductItemHeader(product: product, color: color, listType: listType),
          ProductInfoWidget(
            name: product.productCategory,
            type: product.productName,
            price: product.productPrice,
            disCount: product.productDiscount ?? 0,
          ),
        ],
      ).onlyPadding(topPadding: 25, leftPadding: 16),
    );
  }
}
