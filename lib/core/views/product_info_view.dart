import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../controllers/product_details/product_details_cubit.dart';
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
  late final ProductDetailsCubit productDetailsCubit;

  @override
  void initState() {
    super.initState();
    productDetailsCubit = context.read<ProductDetailsCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
      bloc: productDetailsCubit,
      buildWhen: (previous, current) =>
      current is ProductDetailsLoading ||
          current is ProductDetailsLoaded ||
          current is ProductDetailsError,
      builder: (context, state) {
        if (state is ProductDetailsLoading) {
          return Scaffold(
            body: const Center(child: CircularProgressIndicator()),
          );
        }

        if (state is ProductDetailsLoaded) {
          return Scaffold(
            backgroundColor: AppColors.backGroundColor,
            appBar: ProductInfoAppBar(product: state.product),
            body: ProductInfoBody(product: state.product),
            bottomNavigationBar: AddToCartBottomBar(
              product: state.product,
              productDetailsCubit: productDetailsCubit,
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
