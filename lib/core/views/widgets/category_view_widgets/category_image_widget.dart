import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CategoryImageWidget extends StatelessWidget {
  final String image;
  const CategoryImageWidget({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
        child: image.startsWith('http')
            ? Image.network(
                image,
                width: 171,
                height: 100,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    child: Container(
                      width: 171,
                      height: 100,
                      color: Colors.grey.shade300,
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 171,
                  height: 100,
                  color: Colors.grey.shade300,
                ),
              )
            : Image.asset(image, width: 171, height: 100, fit: BoxFit.cover),
      ),
    );
  }
}
