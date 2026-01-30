import 'package:flutter/material.dart';

import '../../../../core/extensions/app_extentions.dart';

class ProductShimmerItem extends StatelessWidget {
  const ProductShimmerItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 148,
          height: 184,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        8.verticalSizedBox,
        Container(
          height: 12,
          width: 100,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        4.verticalSizedBox,
        Container(
          height: 12,
          width: 50,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ],
    );
  }
}
