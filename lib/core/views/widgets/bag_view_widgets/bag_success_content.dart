import 'package:ecommerceapp/core/views/widgets/bag_view_widgets/cart_list_widget.dart';
import 'package:flutter/material.dart';

import '../../../models/cart_model.dart';

class BagSuccessContent extends StatelessWidget {
  final List<CartModel> products;
  final double totalPrice;

  const BagSuccessContent({
    super.key,
    required this.products,
    required this.totalPrice,
  });

  @override
  Widget build(BuildContext context) {
    return CartListWidget(products: products, totalPrice: totalPrice);
  }
}