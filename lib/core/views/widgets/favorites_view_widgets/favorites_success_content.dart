import 'package:flutter/material.dart';

import '../../../controllers/favorite/favorite_cubit.dart';
import 'favorite_list_widget.dart';
import 'favorites_header.dart';
class FavoritesSuccessContent extends StatelessWidget {
  final FavoriteSuccess state;
  final FavoriteCubit favoriteCubit;

  const FavoritesSuccessContent({
    super.key,
    required this.state,
    required this.favoriteCubit,
  });

  @override
  Widget build(BuildContext context) {
    final catTypes = state.catTypes;
    final filteredProducts = state.selectedCatType == null
        ? state.favoriteProducts
        : state.favoriteProducts
        .where((p) => p.catType == state.selectedCatType)
        .toList(growable: false);

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FavoritesHeader(
            catTypes: catTypes,
            state: state,
            favoriteCubit: favoriteCubit,
          ),
          FavoriteListWidget(products: filteredProducts),
        ],
      ),
    );
  }
}
