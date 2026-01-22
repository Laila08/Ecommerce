import 'package:flutter/material.dart';

import '../../../../extensions/app_extentions.dart';

class ProductImageSection extends StatelessWidget {
  final String image;

  const ProductImageSection({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    final height = context.heigh;

    return Image.asset(
      image,
      height: height * 0.64,
      width: double.infinity,
      fit: BoxFit.cover,
    );
  }
}
