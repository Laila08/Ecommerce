import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import '../../../controllers/view_mode/view_mode_cubit.dart';
import '../../../extensions/app_extentions.dart';
import '../../../theme/app_text_styles.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/constants.dart';

class FavoritesLoadingShimmer extends StatelessWidget {
  const FavoritesLoadingShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    // قراءة وضع الـ Grid أو List
    final isGrid = context.read<ViewModeCubit>().state == ViewMode.grid;
    final width = context.width;
    final gridWidth = (width - 16 * 2 - 16) / 2;

    Widget shimmerCard({double height = 104, double width = double.infinity}) {
      return Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(16),
        ),
      );
    }

    if (isGrid) {
      // Grid shimmer
      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: (gridWidth / 260), // تقريبا نفس شكل البطاقات
        ),
        itemCount: 6,
        itemBuilder: (context, index) => Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          period: const Duration(milliseconds: 1000),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              shimmerCard(height: 170, width: gridWidth),
              8.verticalSizedBox,
              shimmerCard(height: 12, width: gridWidth * 0.7),
              4.verticalSizedBox,
              shimmerCard(height: 12, width: gridWidth * 0.5),
            ],
          ),
        ),
      );
    } else {
      // List shimmer
      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        itemCount: 6,
        itemBuilder: (context, index) => Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          period: const Duration(milliseconds: 1000),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              shimmerCard(height: 104, width: 104),
              10.horizontalSizedBox,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    shimmerCard(height: 20, width: double.infinity),
                    6.verticalSizedBox,
                    shimmerCard(height: 14, width: double.infinity),
                    6.verticalSizedBox,
                    shimmerCard(height: 14, width: width * 0.3),
                  ],
                ),
              ),
            ],
          ).onlyPadding(bottomPadding: 16),
        ),
      );
    }
  }
}
