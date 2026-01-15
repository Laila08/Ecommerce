import 'package:ecommerceapp/core/views/widgets/favorites_view_widgets/filter_section.dart';
import 'package:ecommerceapp/core/views/widgets/favorites_view_widgets/sort_section.dart';
import 'package:flutter/material.dart';

import '../../../extensions/app_extentions.dart';

class ProductFiltersRow extends StatelessWidget {
  const ProductFiltersRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [FilterSection(), SortSection(), const Icon(Icons.list)],
    ).horizontalPadding(16).onlyPadding(topPadding: 16, bottomPadding: 10);
  }
}
