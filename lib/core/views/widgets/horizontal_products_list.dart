import 'package:ecommerceapp/core/extensions/app_extentions.dart';
import 'package:ecommerceapp/core/utils/products_list_type.dart';
import 'package:ecommerceapp/core/models/product_model.dart';
import 'package:flutter/material.dart';

import 'product_item.dart';

class HorizontalProductsList extends StatelessWidget {
  final Color color;
  final ProductsListType listType;
  final List<ProductModel> products;
  const HorizontalProductsList({
    super.key,
    required this.color,
    required this.listType,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    final heigh = context.heigh;
    return SizedBox(
      height: heigh * 0.36,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: products.length,
        itemBuilder: (BuildContext context, int index) => ProductItem(
          product: products[index],
          color: color,
          listType: listType,
        ),
      ),
    );
  }
}
