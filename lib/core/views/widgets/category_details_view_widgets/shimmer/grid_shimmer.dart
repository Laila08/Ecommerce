import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../extensions/app_extentions.dart';

class GridShimmer extends StatelessWidget {
  const GridShimmer({super.key});

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

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double gridWidth = (width - 16 * 2 - 16) / 2;

    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.6,
      ),
      itemCount: 4,
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
  }
}