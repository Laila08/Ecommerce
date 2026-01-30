import 'package:flutter/material.dart';

import '../../../../extensions/app_extentions.dart';
import 'shimmer_card_widget.dart';

class ShimmerListItem extends StatelessWidget {
  final double width;
  const ShimmerListItem({super.key, required this.width});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShimmerCardWidget(width: 104, height: 104),
        10.horizontalSizedBox,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ShimmerCardWidget(width: double.infinity, height: 20),
              6.verticalSizedBox,
              ShimmerCardWidget(width: double.infinity, height: 14),
              6.verticalSizedBox,
              ShimmerCardWidget(width: width * 0.3, height: 14),
            ],
          ),
        ),
      ],
    ).onlyPadding(bottomPadding: 16);
  }
}
