import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../controllers/cart/cart_cubit.dart';
import '../../../../models/product_model.dart';
import '../../../../utils/app_colors.dart';

class InCartIndicator extends StatelessWidget {
  final ProductModel product;

  const InCartIndicator({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        bool isInCart = false;
        if (state is CartISuccess) {
          isInCart = state.cartProducts.any((cartItem) => cartItem.productId == product.productId);
        }

        return isInCart
            ? Positioned(
          bottom: 3,
          right: 0,
          child: CircleAvatar(
            radius: 18,
            backgroundColor: AppColors.primaryColor,
            child: Icon(Icons.shopping_bag, color: AppColors.whiteColor),
          ),
        )
            : const SizedBox.shrink();
      },
    );
  }
}
