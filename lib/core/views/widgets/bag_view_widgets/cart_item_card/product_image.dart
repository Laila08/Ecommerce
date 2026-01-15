import 'package:flutter/material.dart';

class ProductImage extends StatelessWidget {
  final String productImage;

  const ProductImage({super.key, required this.productImage});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(16),
        bottomLeft: Radius.circular(16),
      ),
      child: Image.asset(
        productImage,
        width: 104,
        height: 104,
        fit: BoxFit.cover,
      ),
    );
  }
}
