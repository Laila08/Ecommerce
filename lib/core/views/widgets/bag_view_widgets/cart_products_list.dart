import 'package:ecommerceapp/core/views/widgets/bag_view_widgets/cart_item.dart';
import 'package:flutter/material.dart';

import '../../../models/cart_model.dart';

class CartProductsList extends StatelessWidget {
  final List<CartModel> products;

  const CartProductsList({
    super.key,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: products.length,
      itemBuilder: (context, index) => CartItem(product: products[index]),
    );
  }
}
