import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../controllers/favorite/favorite_cubit.dart';
import 'favorite_list_widget.dart';
import 'favorites_header.dart';

class FavoritesSuccessContent extends StatelessWidget {
  final FavoriteCubit favoriteCubit;

  const FavoritesSuccessContent({super.key, required this.favoriteCubit});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<FavoriteCubit, FavoriteState, FavoriteSuccess?>(
      bloc: favoriteCubit,
      selector: (state) => state is FavoriteSuccess ? state : null,
      builder: (context, state) {
        if (state == null) return const SizedBox.shrink();

        final products = favoriteCubit.sortedProducts;

        return Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FavoritesHeader(
                catTypes: state.catTypes,
                state: state,
                favoriteCubit: favoriteCubit,
              ),
              FavoriteListWidget(
                products: products,
                favoriteCubit: favoriteCubit,
              ),
            ],
          ),
        );
      },
    );
  }
}
