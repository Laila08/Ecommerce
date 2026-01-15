import 'package:flutter/material.dart';

class CategoryImage extends StatelessWidget {
  final String image;

  const CategoryImage({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
        child: image.startsWith('http')
            ? Image.network(image, fit: BoxFit.cover)
            : Image.asset(image, fit: BoxFit.cover),
      ),
    );
  }
}
