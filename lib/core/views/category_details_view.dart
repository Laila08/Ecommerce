import 'package:ecommerceapp/core/views/widgets/category_details_view_widgets/category_details_app_bar.dart';
import 'package:ecommerceapp/core/views/widgets/category_details_view_widgets/category_header.dart';
import 'package:ecommerceapp/core/views/widgets/category_details_view_widgets/category_products_list.dart';
import 'package:flutter/material.dart';

import '../models/product_model.dart';

class CategoryDetailsView extends StatelessWidget {
  final String catName;
  final String gender;
  final List<ProductModel> products;
  final List<String> catTypesList;

  const CategoryDetailsView({
    super.key,
    required this.catName,
    required this.gender,
    required this.products,
    required this.catTypesList,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CategoryDetailsAppBar(),
      body: Column(
        children: [
          CategoryHeader(
            catName: catName,
            gender: gender,
            catTypesList: catTypesList,
          ),
          const CategoryProductsList(),
        ],
      ),
    );
  }
}
