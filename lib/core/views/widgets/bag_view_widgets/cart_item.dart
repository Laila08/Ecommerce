import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../controllers/cart/cart_cubit.dart';
import '../../../extensions/app_extentions.dart';
import '../../../models/cart_model.dart';
import 'cart_item_card/cart_item_card.dart';

class CartItem extends StatelessWidget {
  final CartModel product;

  const CartItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final width = context.width;

    return CartItemCard(
      width: width,
      product: product,
    ).onlyPadding(topPadding: 25);
  }
}