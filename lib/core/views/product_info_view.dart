import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../controllers/product_details/product_details_cubit.dart';
import '../extensions/app_extentions.dart';
import '../utils/app_colors.dart';
import 'widgets/product_info_widgets/add_to_cart_bottom_bar.dart';
import 'widgets/product_info_widgets/product_info_app_bar.dart';
import 'widgets/product_info_widgets/product_info_body.dart';

class ProductInfoView extends StatefulWidget {
  const ProductInfoView({super.key});
  @override
  State<ProductInfoView> createState() => _ProductInfoViewState();
}

class _ProductInfoViewState extends State<ProductInfoView> {
  @override
  Widget build(BuildContext context) {
    final productdetailsCubit = context.read<ProductDetailsCubit>();

    return BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
      bloc: productdetailsCubit,
      buildWhen: (previous, current) =>
          current is ProductDetailsLoading ||
          current is ProductDetailsLoaded ||
          current is ProductDetailsError,
      builder: (context, state) {
        if (state is ProductDetailsLoading) {
          return Scaffold(body: CircularProgressIndicator().center());
        }
        if (state is ProductDetailsLoaded) {
          return Scaffold(
            backgroundColor: AppColors.backGroundColor,
            appBar: ProductInfoAppBar(product: state.product),
            body: ProductInfoBody(product: state.product),
            bottomNavigationBar: AddToCartBottomBar(
              product: state.product,
              productdetailsCubit: productdetailsCubit,
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}

