import 'package:flutter/material.dart';
import 'grid_shimmer.dart';
import 'list_shimmer.dart';
class CategoryDetailsLoading extends StatelessWidget {
  final bool isGrid;
  const CategoryDetailsLoading({super.key, required this.isGrid});

  @override
  Widget build(BuildContext context) {
    return isGrid ? GridShimmer() : ListShimmer();
  }
}

