import 'package:ecommerceapp/core/controllers/cart/cart_cubit.dart';
import 'package:ecommerceapp/core/controllers/favorite/favorite_cubit.dart';
import 'package:ecommerceapp/core/controllers/home/home_cubit.dart';
import 'package:ecommerceapp/core/extensions/app_extentions.dart';
import 'package:ecommerceapp/core/theme/app_text_styles.dart';
import 'package:ecommerceapp/core/utils/app_colors.dart';
import 'package:ecommerceapp/core/models/product_model.dart';
import 'package:ecommerceapp/core/views/widgets/product_badge_widget.dart';
import 'package:ecommerceapp/core/views/widgets/rating_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteItemWidget extends StatelessWidget {
  final ProductModel product;

  const FavoriteItemWidget({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final favoriteCubit = BlocProvider.of<FavoriteCubit>(context);
    final width = context.width;
    return Stack(
      children: [
        Column(
          children: [
            _itemCard(width, product, favoriteCubit,),
            Container(color: AppColors.backGroundColor, height: 20,),
          ],
        ),
        BlocBuilder<HomeCubit, HomeState>(
          bloc: BlocProvider.of<HomeCubit>(context),
          builder: (context, state) {
            bool isHaveDiscount = false;
            bool isNew = false;

            if (state is HomeSuccess) {
              isHaveDiscount = state.salesProducts
                  .any((p) => p.productId == product.productId && (p.productDiscount ?? 0) > 0);
              if (!isHaveDiscount) {
                isNew = state.newProducts
                    .any((p) => p.productId == product.productId);
              }
            }

            return  isHaveDiscount
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
              isInCart = state.cartProducts
                  .any((cartItem) => cartItem.productId == product.productId);
            }
            return isInCart ? Positioned(
              bottom: 3,
              right: 0,
              child: CircleAvatar(
                radius: 18,
                backgroundColor: AppColors.primaryColor,
                child: Icon(Icons.shopping_bag, color: AppColors.whiteColor),
              ),
            ) : SizedBox();
          },
        ),
      ],
    ).onlyPadding(topPadding: 15,leftPadding: 16,rightPadding: 16);
  }
}

Widget _itemCard(double width,
    ProductModel product,
    FavoriteCubit favoriteCubit,
    ) {
  return BlocBuilder<FavoriteCubit, FavoriteState>(
    builder: (context, state) {
      return Container(
        width: width,
        height: 104,
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: 16.allBorderRadius,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ClipRRect(
              borderRadius: BorderRadiusGeometry.only(
                topLeft: Radius.circular(16),
                bottomLeft: Radius.circular(16),
              ),
              child: Image.asset(
                product.productImage,
                width: 104,
                height: 104,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.productName,
                    style: AppTextStyles.font16BlackWeight400,
                  ),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${product.productPrice}\$",
                        style: AppTextStyles.font14blackWeight500,
                      ),
                      RatingWidget(product: product),
                    ],
                  ).onlyPadding(topPadding: 20, rightPadding: 15),
                ],
              ).onlyPadding(topPadding: 16, leftPadding: 7),
            ),
            BlocBuilder<FavoriteCubit, FavoriteState>(
              bloc:favoriteCubit,
              builder: (context, state) {
                return InkWell(
                  onTap: () => favoriteCubit.toggleFavorite(product),
                  child: Icon(
                    Icons.close,
                    color: AppColors.grayColor,
                    size: 17,
                  ).onlyPadding(rightPadding: 16, topPadding: 16),
                );
              }
            ),
          ],
        ),
      );
    },
  );
}
