import 'package:ecommerceapp/core/components/widgets/arrow_back_icon.dart';
import 'package:ecommerceapp/core/components/widgets/favorite_icon_widget.dart';
import 'package:ecommerceapp/core/components/widgets/main_button.dart';
import 'package:ecommerceapp/core/controllers/favorite/favorite_cubit.dart';
import 'package:ecommerceapp/core/controllers/product_details/product_details_cubit.dart';
import 'package:ecommerceapp/core/extensions/app_extentions.dart';
import 'package:ecommerceapp/core/theme/app_text_styles.dart';
import 'package:ecommerceapp/core/utils/app_colors.dart';
import 'package:ecommerceapp/core/views/widgets/drop_down_widget.dart';
import 'package:ecommerceapp/core/views/widgets/rating_widget.dart';
import 'package:ecommerceapp/core/views/widgets/text_header_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/models/product_model.dart';

class ProductInfoView extends StatefulWidget {
  const ProductInfoView({super.key});

  @override
  State<ProductInfoView> createState() => _ProductInfoViewState();
}

class _ProductInfoViewState extends State<ProductInfoView> {
  @override
  Widget build(BuildContext context) {
    Widget bottomNavigationBar(
      ProductDetailsCubit productdetailsCubit,
      ProductModel product,
    ) {
      return Container(
        height: 78,
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          boxShadow: [
            BoxShadow(
              color: AppColors.blackColor.withValues(alpha: 0.10),
              blurRadius: 8,
              spreadRadius: 0,
              offset: Offset(0, -4),
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
                const SnackBar(content: Text('Product added to the cart!')),
              );
            } else if (state is AddToCartError) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.error)));
            }
          },
          builder: (context, state) {
            if (state is AddingToCart) {
              return MainButton(
                child: const CircularProgressIndicator.adaptive(),
              );
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

    final height = context.heigh;
    final productdetailsCubit = BlocProvider.of<ProductDetailsCubit>(context);
    final favoriteCubit = BlocProvider.of<FavoriteCubit>(context);

    return BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
      bloc: productdetailsCubit,
      buildWhen: (previous, current) =>
          current is ProductDetailsLoading ||
          current is ProductDetailsLoaded ||
          current is ProductDetailsError,
      builder: (context, state) {
        if (state is ProductDetailsLoading) {
          return Scaffold(body: CircularProgressIndicator().center());
        } else if (state is ProductDetailsLoaded) {
          final product = state.product;
          return Scaffold(
            backgroundColor: AppColors.backGroundColor,
            appBar: AppBar(
              title: Text(
                product.productName,
                style: AppTextStyles.font18BlackWeight400,
              ),
              centerTitle: true,
              leading: ArrowBackIcon().onlyPadding(leftPadding: 16),
              actions: [
                Icon(
                  Icons.share,
                  color: AppColors.blackColor,
                ).onlyPadding(rightPadding: 16),
              ],
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Image.asset(
                    product.productImage,
                    height: height * 0.64,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 60,
                          child: DropDownWidget(
                            onChanged: (String? newSize) =>
                                productdetailsCubit.setSize(newSize!),
                            items: ['XS', 'S', 'M', 'L', 'XL'],
                            hint: "Size",
                            textStyle: AppTextStyles.font11BlackWeight400,
                          ),
                        ),
                      ),
                      16.horizontalSizedBox,
                      Expanded(
                        child: SizedBox(
                          height: 60,
                          child: DropDownWidget(
                            onChanged: (String? newColor) =>
                                productdetailsCubit.setColor(newColor!),
                            items: ['Black', 'Red', 'Gray', 'White'],
                            hint: "Black",
                            textStyle: AppTextStyles.font11BlackWeight400,
                          ),
                        ),
                      ),
                      16.horizontalSizedBox,
                      BlocBuilder<FavoriteCubit, FavoriteState>(
                        builder: (context, favState) {
                          bool isFav = false;
                          if (favState is FavoriteSuccess) {
                            isFav = favState.favoriteProducts.any((p) => p.productId == product.productId);
                          }
                          return FavoriteIconWidget(
                            isFavorite: isFav,
                            onTap: () {
                              favoriteCubit.toggleFavorite(product);
                            },
                          );
                        },
                      ),

                    ],
                  ).onlyPadding(
                    topPadding: 16,
                    leftPadding: 16,
                    rightPadding: 16,
                  ),
                  TextHeaderWidget(
                    title: product.productName,
                    subTitle: "Short dress",
                    trailingText: "\$${product.productPrice}",
                    textStyle: AppTextStyles.font24BlackWeight400,
                    function: () {},
                    titleStyle: AppTextStyles.font24BlackWeight400,
                    subTitleStyle: AppTextStyles.font11GrayWeight400,
                  ),
                  RatingWidget(product: product).horizontalPadding(16),
                  5.verticalSizedBox,
                  Text(
                    "Short dress in soft cotton jersey with decorative buttons down the front and a wide, frill-trimmed square neckline with concealed elastication. Elasticated seam under the bust and short puff sleeves with a small frill trim.",
                    style: AppTextStyles.font14BlackWeight400,
                  ).horizontalPadding(16),
                  10.verticalSizedBox,
                ],
              ),
            ),
            bottomNavigationBar: bottomNavigationBar(
              productdetailsCubit,
              product,
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
