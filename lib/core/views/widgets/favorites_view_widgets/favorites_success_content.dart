import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../controllers/favorite/favorite_cubit.dart';
import 'favorite_list_widget.dart';
import 'favorites_header.dart';
class FavoritesSuccessContent extends StatelessWidget {
  final FavoriteCubit favoriteCubit;

  const FavoritesSuccessContent({
    super.key,
    required this.favoriteCubit,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteCubit, FavoriteState>(
      builder: (context, state) {
        if (state is! FavoriteSuccess) {
          return const SizedBox();
        }

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

