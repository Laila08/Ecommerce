import 'package:flutter/material.dart';

import '../../../utils/constants.dart';
import 'product_grid_item.dart';

class GridProductsView extends StatelessWidget {
  final List products;
  const GridProductsView({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: calculateChildAspectRatio(context, 260),
      ),
      itemCount: products.length,
      itemBuilder: (context, index) => ProductGridItem(product: products[index]),
    );
  }
}