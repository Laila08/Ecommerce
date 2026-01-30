import 'package:flutter/material.dart';

import '../../../controllers/category/category_cubit.dart';
import 'category_list_widget.dart';

class CategoryTabView extends StatelessWidget {
  final String gender;
  final CategoryCubit categoryCubit;

  const CategoryTabView({super.key, required this.gender, required this.categoryCubit});

  @override
  Widget build(BuildContext context) {
    final products = categoryCubit.getProductsByGender(gender);
    return CategoryListWidget(
      gender: gender,
      products: products,
    );
  }
}