import 'package:ecommerceapp/core/controllers/cart/cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../components/widgets/loading_button_widget.dart';
import '../../../components/widgets/main_button.dart';
import '../../../controllers/product_details/product_details_cubit.dart';
import '../../../extensions/app_extentions.dart';
import '../../../models/product_model.dart';
import '../../../utils/app_colors.dart';

class AddToCartBottomBar extends StatelessWidget {
  final ProductDetailsCubit productdetailsCubit;
  final ProductModel product;

  const AddToCartBottomBar({
    super.key,
    required this.productdetailsCubit,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 78,
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        boxShadow: [
          BoxShadow(
            color: AppColors.blackColor.withValues(alpha: 0.10),
            blurRadius: 8,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      padding: 16.allPading,
      child: BlocConsumer<ProductDetailsCubit, ProductDetailsState>(
        bloc: productdetailsCubit,
        listenWhen: (previous, current) =>
            current is AddedToCart || current is AddToCartError,
        listener: (context, state) {
          if (state is AddedToCart) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Product added to the cart!'),
                backgroundColor: AppColors.primaryColor,
              ),
            );
          } else if (state is AddToCartError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
                backgroundColor: AppColors.primaryColor,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is AddingToCart) {
            return LoadingButtonWidget();
          }
          return MainButton(
            title: "ADD TO CART",
            onTap: () async {
              await productdetailsCubit.addToCart(product);
            },
          );
        },
      ),
    );
  }
}
