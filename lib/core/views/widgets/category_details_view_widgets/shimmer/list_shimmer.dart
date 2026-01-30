import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../extensions/app_extentions.dart';

class ListShimmer extends StatelessWidget {
  const ListShimmer({super.key});

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

    return ListView.builder(
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
