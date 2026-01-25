import 'package:ecommerceapp/core/models/product_model.dart';
import 'package:ecommerceapp/core/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../extensions/app_extentions.dart';
import '../../../theme/app_text_styles.dart';

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
        margin: EdgeInsets.only(right: 8, left: 8, top: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: 16.allBorderRadius,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                catName,
                style: AppTextStyles.font18BlackWeight400,
              ).onlyPadding(leftPadding: 15),
            ),
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
                child: catImage.startsWith('http')
                    ?  Image.network(
                  catImage,
                  width: 171,
                  height: 100,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    // هنا الشيمر
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
                )
                    : Image.asset(
                        catImage,
                        width: 171,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
