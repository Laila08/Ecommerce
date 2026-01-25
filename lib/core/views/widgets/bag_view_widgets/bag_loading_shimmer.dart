import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../../extensions/app_extentions.dart';
import '../../../utils/app_colors.dart';

class BagLoadingShimmer extends StatelessWidget {
  const BagLoadingShimmer({super.key});

  Widget productShimmer(BuildContext context) {
    final width = context.width;
    return Container(
      width: width,
      height: 104,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // صورة المنتج
          Container(
            width: 104,
            height: 104,
            decoration: BoxDecoration(
              color: AppColors.grayColor.withOpacity(0.3),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                bottomLeft: Radius.circular(16),
              ),
            ),
          ),
          const SizedBox(width: 10),
          // تفاصيل المنتج
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 150,
                    height: 16,
                    color: AppColors.grayColor.withOpacity(0.3),
                  ),
                  8.verticalSizedBox,
                  Container(
                    width: 100,
                    height: 12,
                    color: AppColors.grayColor.withOpacity(0.3),
                  ),
                  8.verticalSizedBox,
                  Container(
                    width: 80,
                    height: 12,
                    color: AppColors.grayColor.withOpacity(0.3),
                  ),
                ],
              ),
            ),
          ),
          // سعر المنتج
          Padding(
            padding: const EdgeInsets.only(top: 15, right: 20),
            child: Container(
              width: 40,
              height: 14,
              color: AppColors.grayColor.withOpacity(0.3),
            ),
          ),
        ],
      ),
    ).onlyPadding(topPadding: 16);
  }

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      period: const Duration(milliseconds: 1000),
      child: SingleChildScrollView(
        child: Column(
          children: List.generate(
            5, // عدد العناصر التي ستظهر كـ shimmer
                (index) => productShimmer(context),
          ),
        ),
      ),
    );
  }
}
