import 'package:flutter/material.dart';

import '../../../extensions/app_extentions.dart';
import '../../../models/product_model.dart';
import '../../../routes/routes.dart';
import 'category_image_widget.dart';
import 'category_text.dart';

class CategoryItem extends StatelessWidget {
  final String catImage;
  final String catName;
  final String gender;
  final List<ProductModel> products;
  final List<String> catTypesList;

  const CategoryItem({
    super.key,
    required this.catImage,
    required this.catName,
    required this.products,
    required this.gender,
    required this.catTypesList,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.pushNamed(
          Routes.categoryProduct,
          arguments: {
            'catName': catName,
            'products': products,
            'gender': gender,
            'catTypesList': catTypesList,
          },
        );
      },
      child: Container(
        height: 100,
        margin: const EdgeInsets.only(right: 8, left: 8, top: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: 16.allBorderRadius,
        ),
        child: Row(
          children: [
            CategoryText(catName: catName),
            CategoryImageWidget(image: catImage),
          ],
        ),
      ),
    );
  }
}
