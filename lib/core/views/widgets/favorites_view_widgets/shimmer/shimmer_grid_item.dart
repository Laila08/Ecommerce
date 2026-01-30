import 'package:flutter/material.dart';

import '../../../../extensions/app_extentions.dart';
import 'shimmer_card_widget.dart';

class ShimmerGridItem extends StatelessWidget {
  final double width;
  const ShimmerGridItem({super.key, required this.width});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShimmerCardWidget(width: width, height: 170),
        8.verticalSizedBox,
        ShimmerCardWidget(width: width * 0.7, height: 12),
        4.verticalSizedBox,
        ShimmerCardWidget(width: width * 0.5, height: 12),
      ],
    );
  }
}
