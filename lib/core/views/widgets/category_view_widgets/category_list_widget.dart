import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../controllers/category/category_cubit.dart';
import '../../../models/product_model.dart';
import '../../../utils/constants.dart';
import '../../../utils/products_list_type.dart';
import 'category_item.dart';

class CategoryListWidget extends StatelessWidget {
  final String gender;
  final List<ProductModel> products;

  const CategoryListWidget({
    super.key,
    required this.gender,
    required this.products,
  });

  static const List<ProductsListType> _productsList = [
    ProductsListType.New,
    ProductsListType.Clothes,
    ProductsListType.Shoes,
    ProductsListType.Accesories,
  ];

  @override
  Widget build(BuildContext context) {
    final categoryCubit = context.read<CategoryCubit>();

    return ListView.builder(
      itemCount: _productsList.length,
      itemBuilder: (context, index) {
        final category = _productsList[index];

        final filteredProducts = categoryCubit.getProductsByCategory(
          gender,
          category,
        );

        final catTypesList = categoryCubit.getCatTypes(gender, category);

        return CategoryItem(
          catImage: getImageList(gender)[index],
          gender: gender,
          catName: category.name,
          products: filteredProducts,
          catTypesList: catTypesList,
        );
      },
    );
  }
}
