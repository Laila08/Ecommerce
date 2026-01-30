import 'package:flutter/material.dart';

import '../../../components/widgets/rating_widget.dart';
import '../../../extensions/app_extentions.dart';
import '../../../models/product_model.dart';
import 'product_info_body/product_description_section.dart';
import 'product_info_body/product_header_section.dart';
import 'product_info_body/product_image_section.dart';
import 'product_info_body/product_options_row.dart';

class ProductInfoBody extends StatelessWidget {
  final ProductModel product;

  const ProductInfoBody({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ProductImageSection(image: product.productImage),
          ProductOptionsRow(product: product),
          ProductHeaderSection(product: product),
          RatingWidget(product: product)
              .horizontalPadding(16)
              .onlyPadding(bottomPadding: 15, topPadding: 5),
          ProductDescriptionSection(description: product.desc),
          15.verticalSizedBox,
        ],
      ),
    );
  }
}
