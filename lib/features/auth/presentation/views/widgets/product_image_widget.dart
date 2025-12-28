import 'package:flutter/material.dart';

import '../../../../../core/extensions/app_extentions.dart';
class ProductImageWidget extends StatelessWidget {
  final String image;
  final double width;
  final double height;
  const ProductImageWidget({super.key, required this.image, required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: 16.allBorderRadius,
      child: Image.asset(
        image,
        width: width,
        height: height,
        fit: BoxFit.cover,
      ),
    );
  }
}
