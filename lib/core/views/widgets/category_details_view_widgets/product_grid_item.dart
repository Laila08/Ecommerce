import 'package:ecommerceapp/core/models/product_model.dart';
import 'package:ecommerceapp/core/views/widgets/category_details_view_widgets/product_cat_item/product_image_section.dart';
import 'package:flutter/material.dart';
import '../../../extensions/app_extentions.dart';
import '../../../routes/routes.dart';
import '../product_info_widgets/product_info_widget.dart';

class ProductGridItem extends StatelessWidget {
  final ProductModel product;

  const ProductGridItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    double imageWidth = (MediaQuery.of(context).size.width - 16 * 2 - 16) / 2;

    return InkWell(
      onTap: () {
        context.pushNamed(Routes.productinfo, arguments: product.productId);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProductImageSection(product: product, width: imageWidth),
          ProductInfoWidget(
            name: product.productCategory,
            type: product.productName,
            price: product.productPrice,
            disCount: product.productDiscount ?? 0,
          ),
        ],
      ),
    );
  }
}
