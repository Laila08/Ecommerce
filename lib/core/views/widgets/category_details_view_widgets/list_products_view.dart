import 'package:flutter/material.dart';

import '../category_view_widgets/product_cat_item.dart';

class ListProductsView extends StatelessWidget {
  final List products;
  const ListProductsView({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) => ProductCatItem(product: products[index]),
    );
  }
}