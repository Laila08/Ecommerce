import 'package:ecommerceapp/core/extensions/app_extentions.dart';
import 'package:ecommerceapp/core/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../controllers/cart/cart_cubit.dart';
import '../../../../controllers/favorite/favorite_cubit.dart';
import '../../../../controllers/home/home_cubit.dart';
import '../../../../routes/routes.dart';
import '../build_product_info.dart';
import 'product_stack.dart';

class ProFavGridItem extends StatelessWidget {
  final ProductModel product;

  const ProFavGridItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final favoriteCubit = context.read<FavoriteCubit>();
    final width = (context.width - 16 * 2 - 16) / 2;
    final discount = product.productDiscount ?? 0;
    final finalPrice = product.productPrice * (1 - discount / 100);

    final isInCart = context.select(
      (CartCubit c) =>
          c.state is CartISuccess &&
          (c.state as CartISuccess).cartProducts.any(
            (item) => item.productId == product.productId,
          ),
    );

    final isNewOrDiscounted = context.select((HomeCubit c) {
      bool isDiscounted = false;
      bool isNew = false;
      final state = c.state;
      if (state is HomeSuccess) {
        isDiscounted = state.salesProducts.any(
          (p) =>
              p.productId == product.productId && (p.productDiscount ?? 0) > 0,
        );
        if (!isDiscounted) {
          isNew = state.newProducts.any(
            (p) => p.productId == product.productId,
          );
        }
      }
      return {'isDiscounted': isDiscounted, 'isNew': isNew};
    });

    return InkWell(
      onTap: () {
        context.pushNamed(Routes.productinfo, arguments: product.productId);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProductStack(
            product: product,
            width: width,
            discount: discount,
            isInCart: isInCart,
            isNewOrDiscounted: isNewOrDiscounted,
            favoriteCubit: favoriteCubit,
          ),
          BuildProductInfo(
            finalPrice: finalPrice,
            discount: discount,
            product: product,
          ),
        ],
      ),
    );
  }
}
