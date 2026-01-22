import 'package:ecommerceapp/core/components/widgets/title_header_widget.dart';

import '../../../controllers/favorite/favorite_cubit.dart';

import 'package:flutter/material.dart';

import '../../../utils/app_colors.dart';
import 'favorites_categories.dart';
import 'favorites_filters_row.dart';

class FavoritesHeader extends StatelessWidget {
  final List<String> catTypes;
  final FavoriteSuccess state;
  final FavoriteCubit favoriteCubit;

  const FavoritesHeader({
    super.key,
    required this.catTypes,
    required this.state,
    required this.favoriteCubit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        boxShadow: [
          BoxShadow(
            color: AppColors.blackColor.withValues(alpha: 0.12),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TitleHeaderWidget(title: 'Favorites'),
          catTypes.isEmpty
              ? SizedBox()
              : FavoritesCategories(
                  catTypes: catTypes,
                  state: state,
                  favoriteCubit: favoriteCubit,
                ),
          ProductFiltersRow(sortCubit: favoriteCubit.sortCubit,),
        ],
      ),
    );
  }
}
