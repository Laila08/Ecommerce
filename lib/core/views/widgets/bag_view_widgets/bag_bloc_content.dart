import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../controllers/cart/cart_cubit.dart';
import '../../../extensions/app_extentions.dart';
import 'bag_loading_shimmer.dart';
import 'bag_success_content.dart';

class BagBlocContent extends StatelessWidget {
  const BagBlocContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      buildWhen: (previous, current) =>
          current is CartILoading ||
          current is CartISuccess ||
          current is CartIFailed,
      builder: (context, state) {
        if (state is CartILoading) {
          return const BagLoadingShimmer();
        } else if (state is CartIFailed) {
          return Text(state.error).center();
        } else if (state is CartISuccess) {
          return BagSuccessContent(
            products: state.cartProducts,
            totalPrice: state.totalPrice,
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
