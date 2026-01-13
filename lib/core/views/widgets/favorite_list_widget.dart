import 'package:ecommerceapp/core/extensions/app_extentions.dart';
import 'package:ecommerceapp/core/models/product_model.dart';
import 'package:flutter/material.dart';

import 'favorite_item_widget.dart';

class FavoriteListWidget extends StatelessWidget {
  final List<ProductModel> products;
  const FavoriteListWidget({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: products.length,
        itemBuilder: (BuildContext context, int index) =>
            FavoriteItemWidget(
              product:products[index],
            ),
      ),
    );
  }
}
