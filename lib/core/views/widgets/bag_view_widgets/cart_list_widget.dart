import 'package:ecommerceapp/core/extensions/app_extentions.dart';
import 'package:ecommerceapp/core/utils/app_messages.dart';
import 'package:flutter/material.dart';
import '../../../models/cart_model.dart';
import 'cart_checkout_button.dart';
import 'cart_products_list.dart';
import 'cart_total_row.dart';

class CartListWidget extends StatelessWidget {
  final List<CartModel> products;
  final double totalPrice;

  const CartListWidget({
    super.key,
    required this.products,
    required this.totalPrice,
  });

  @override
  Widget build(BuildContext context) {
    return products.isEmpty
        ? Text(AppMessages.noProduct).center()
        : SingleChildScrollView(
            child: Column(
              children: [
                CartProductsList(products: products),
                CartTotalRow(totalPrice: totalPrice),
                CartCheckoutButton(totalPrice: totalPrice),
              ],
            ),
          );
  }
}
