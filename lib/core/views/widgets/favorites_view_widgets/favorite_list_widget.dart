import 'package:ecommerceapp/core/controllers/favorite/favorite_cubit.dart';
import 'package:ecommerceapp/core/models/product_model.dart';
import 'package:ecommerceapp/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../controllers/view_mode/view_mode_cubit.dart';
import '../../../extensions/app_extentions.dart';
import '../../../utils/constants.dart';
import 'favorite_item_widget.dart';
import 'pro_fav_grid_item.dart';

class FavoriteListWidget extends StatelessWidget {
  final List<ProductModel> products;
  final FavoriteCubit favoriteCubit;
  const FavoriteListWidget({
    super.key,
    required this.products,
    required this.favoriteCubit,
  });

  @override
  Widget build(BuildContext context) {
    return  Expanded(
      child: BlocBuilder<ViewModeCubit, ViewMode>(
        builder: (context, mode) {
          return mode == ViewMode.list
            ? products.isEmpty ?Text("There is no Data",style: AppTextStyles.font16BlackWeight400,).center():ListView.builder(
          itemCount: products.length,
          itemBuilder: (BuildContext context, int index) =>
              FavoriteItemWidget(product:  products[index]),
        ) : products.isEmpty ?Text("There is no Data",style: AppTextStyles.font16BlackWeight400,).center():GridView.builder(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),

          gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: ( context.width - 19*2 - 16) / 2  / 260,
          ),
          itemCount: products.length,
          itemBuilder: (context, index) =>
              ProFavGridItem(product: products[index]),
        );
        },
      )
    );
  }
}
