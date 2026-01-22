import 'package:ecommerceapp/core/extensions/app_extentions.dart';
import 'package:ecommerceapp/core/theme/app_text_styles.dart';
import 'package:ecommerceapp/core/components/widgets/product_image_widget.dart';
import 'package:ecommerceapp/core/components/widgets/rating_widget.dart';
import 'package:ecommerceapp/core/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../controllers/cart/cart_cubit.dart';
import '../../../controllers/favorite/favorite_cubit.dart';
import '../../../controllers/home/home_cubit.dart';
import '../../../utils/app_colors.dart';
import '../../../components/widgets/product_badge_widget.dart';


class ProFavGridItem extends StatelessWidget {
  final ProductModel product;

  const ProFavGridItem({super.key, required this.product,});

  @override
  Widget build(BuildContext context) {
    double finalPrice = product.productPrice * (1 - product.productDiscount! / 100);
    final favoriteCubit = BlocProvider.of<FavoriteCubit>(context);
    double imageWidth = (MediaQuery.of(context).size.width - 16*2 - 16) / 2;

    return InkWell(
      onTap:(){
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProductImageWidget(
                    image:
                    product.productImage,
                    width:imageWidth,
                    height: 170,
                  ),
                  RatingWidget(product: product).onlyPadding(topPadding: 5),
                ],
              ),
              product.productDiscount==0?SizedBox():ProductBadgeWidget(
                title: "-${product.productDiscount}%",
                color: AppColors.primaryColor,
                textStyle: AppTextStyles.font11WhiteWeight400,
              ),
              BlocBuilder<HomeCubit, HomeState>(
                bloc: BlocProvider.of<HomeCubit>(context),
                builder: (context, state) {
                  bool isHaveDiscount = false;
                  bool isNew = false;

                  if (state is HomeSuccess) {
                    isHaveDiscount = state.salesProducts.any(
                          (p) =>
                      p.productId == product.productId &&
                          (p.productDiscount ?? 0) > 0,
                    );
                    if (!isHaveDiscount) {
                      isNew = state.newProducts.any(
                            (p) => p.productId == product.productId,
                      );
                    }
                  }

                  return isHaveDiscount
                      ? ProductBadgeWidget(
                    title: "${product.productDiscount}%",
                    color: AppColors.primaryColor,
                    textStyle: AppTextStyles.font11WhiteWeight400,
                  )
                      : isNew
                      ? ProductBadgeWidget(
                    title: "New",
                    color: AppColors.blackColor,
                    textStyle: AppTextStyles.font11WhiteWeight400,
                  )
                      : SizedBox();
                },
              ),
              BlocBuilder<CartCubit, CartState>(
                bloc: BlocProvider.of<CartCubit>(context),
                builder: (context, state) {
                  bool isInCart = false;
                  if (state is CartISuccess) {
                    isInCart = state.cartProducts.any(
                          (cartItem) => cartItem.productId == product.productId,
                    );
                  }
                  return isInCart
                      ? Positioned(
                    bottom: 3,
                    right: 0,
                    child: CircleAvatar(
                      radius: 18,
                      backgroundColor: AppColors.primaryColor,
                      child: Icon(
                        Icons.shopping_bag,
                        color: AppColors.whiteColor,
                      ),
                    ),
                  )
                      : SizedBox();
                },
              ),
              BlocBuilder<FavoriteCubit, FavoriteState>(
                bloc: favoriteCubit,
                builder: (context, state) {
                  return Positioned(
                    top: 10,
                    right: 10,
                    child: InkWell(
                      onTap: () => favoriteCubit.toggleFavorite(product),
                      child: Icon(
                        Icons.close,
                        color: AppColors.grayColor,
                        size: 17,
                      ),
                    ),
                  );
                },
              )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(product.productCategory, style: AppTextStyles.font11GrayWeight400),
              Text(product.productName, style: AppTextStyles.font16BlackWeight400),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: "Color: ",
                      style: AppTextStyles.font11GrayWeight400,
                    ),
                    TextSpan(
                      text: "_   ",
                      style: AppTextStyles.font11BlackWeight400,
                    ),
                    TextSpan(
                      text: "         Size: ",
                      style: AppTextStyles.font11GrayWeight400,
                    ),
                    TextSpan(
                      text: "_",
                      style: AppTextStyles.font11BlackWeight400,
                    ),
                  ],
                ),
              ),
              product.productDiscount == 0
                  ? Text("${product.productPrice.toString()}\$ ",style: AppTextStyles.font14blackWeight500,)
                  : Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: "${product.productPrice.toString()}\$ ",
                      style: TextStyle(
                        fontSize: 11,
                        color: AppColors.grayColor,
                        fontWeight: FontWeight.w400,
                        decoration: product.productDiscount! > 0
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                      ),
                    ),

                    product.productDiscount != 0
                        ? TextSpan(
                      text: " ${finalPrice.toString()}\$",
                      style: TextStyle(
                        fontSize: 11,
                        color: AppColors.primaryColor,
                        decoration: TextDecoration.none,
                      ),
                    )
                        : TextSpan(),
                  ],
                ),
              ),
            ],
          ),

        ],
      ),
    );
  }
}
