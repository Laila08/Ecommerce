import 'package:flutter/material.dart';

class ShimmerCardWidget extends StatelessWidget {
  final double width;
  final double height;

  const ShimmerCardWidget({
    super.key,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(16),
      ),
    );
  }
}
