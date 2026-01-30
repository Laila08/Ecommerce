import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../controllers/view_mode/view_mode_cubit.dart';
import '../../../../extensions/app_extentions.dart';
import '../../../../utils/constants.dart';
import 'shimmer_grid_item.dart';
import 'shimmer_list_item.dart';

class FavoritesLoadingShimmer extends StatelessWidget {
  const FavoritesLoadingShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final isGrid = context.read<ViewModeCubit>().state == ViewMode.grid;
    final width = context.width;
    final gridWidth = (width - 16 * 2 - 16) / 2;

    Widget buildShimmerItem() => isGrid
        ? ShimmerGridItem(width: gridWidth)
        : ShimmerListItem(width: width);

    return isGrid
        ? GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: (gridWidth / 260),
            ),
            itemCount: 6,
            itemBuilder: (_, _) => Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              period: const Duration(milliseconds: 1000),
              child: buildShimmerItem(),
            ),
          )
        : ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            itemCount: 6,
            itemBuilder: (_, _) => Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              period: const Duration(milliseconds: 1000),
              child: buildShimmerItem(),
            ),
          );
  }
}
