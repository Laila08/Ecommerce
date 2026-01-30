import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../extensions/app_extentions.dart';
import '../../../utils/app_colors.dart';

class AddressCardShimmer extends StatelessWidget {
  const AddressCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: 16.allPading,
      width: 343,
      height: 140,
      decoration: BoxDecoration(
        borderRadius: 16.allBorderRadius,
        color: AppColors.whiteColor,
        boxShadow: [
          BoxShadow(
            color: AppColors.blackColor.withValues(alpha: 0.08),
            blurRadius: 25,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                _box(width: 120, height: 14),
                const Spacer(),
                _box(width: 40, height: 14),
              ],
            ).onlyPadding(bottomPadding: 12),

            _box(width: double.infinity, height: 12)
                .onlyPadding(bottomPadding: 20),

            // Checkbox row
            Row(
              children: [
                _box(width: 20, height: 20, radius: 4),
                const SizedBox(width: 12),
                _box(width: 160, height: 14),
              ],
            ),
          ],
        ).onlyPadding(leftPadding: 28, rightPadding: 28, topPadding: 16),
      ),
    );
  }

  Widget _box({
    required double width,
    required double height,
    double radius = 8,
  }) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }
}