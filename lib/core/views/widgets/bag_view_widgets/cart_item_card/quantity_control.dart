import 'package:ecommerceapp/core/components/widgets/favorite_icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../controllers/cart/cart_cubit.dart';
import '../../../../extensions/app_extentions.dart';
import '../../../../models/cart_model.dart';
import '../../../../theme/app_text_styles.dart';
import '../../../../utils/app_colors.dart';
import '../../circle_icon_widget.dart';

class QuantityControl extends StatelessWidget {
  final CartModel product;
  final CartCubit cartCubit;

  const QuantityControl({
    super.key,
    required this.product,
    required this.cartCubit,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        BlocBuilder<CartCubit, CartState>(
          bloc: cartCubit,
          buildWhen: (previous, current) =>
              current is CartISuccess ||
              current is CartILoading ||
              current is CartIFailed,
          builder: (context, state) {
            if (state is CartILoading) {
              return CircularProgressIndicator().center();
            }
            return CircleIconWidget(
              icon: Icons.minimize,
              color: AppColors.grayColor,
              onTap: () => cartCubit.oddQuantity(product),
            );
          },
        ),
        10.horizontalSizedBox,
        Text(
          product.quantity.toString(),
          style: AppTextStyles.font14blackWeight500,
        ),
        10.horizontalSizedBox,
        CircleIconWidget(
          icon: Icons.add,
          color: AppColors.grayColor,
          onTap: () => cartCubit.addQuantity(product),
        ),
      ],
    ).onlyPadding(topPadding: 12);
  }
}
