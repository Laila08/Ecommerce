import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../components/widgets/failed_state_widget.dart';
import '../../../controllers/favorite/favorite_cubit.dart';
import '../../../extensions/app_extentions.dart';
import 'favorites_loading_shimmer.dart';
import 'favorites_success_content.dart';

class FavoritesBody extends StatelessWidget {
  const FavoritesBody({super.key});

  @override
  Widget build(BuildContext context) {
    final favoriteCubit = context.read<FavoriteCubit>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BlocBuilder<FavoriteCubit, FavoriteState>(
          bloc: favoriteCubit,
          buildWhen: (previous, current) =>
              current is FavoriteLoading ||
              current is FavoriteSuccess ||
              current is FavoriteFailed,
          builder: (context, state) {
            if (state is FavoriteLoading) {
              return const FavoritesLoadingShimmer();
            } else if (state is FavoriteFailed) {
              return FailedStateWidget(text:state.error,);
            } else if (state is FavoriteSuccess) {
              return FavoritesSuccessContent(
                favoriteCubit: favoriteCubit,
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ],
    );
  }
}
