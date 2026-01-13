import 'package:ecommerceapp/core/controllers/home/home_cubit.dart';
import 'package:ecommerceapp/core/models/product_model.dart';
import 'package:ecommerceapp/core/utils/products_list_type.dart';
import 'package:ecommerceapp/core/views/widgets/categoryViewWidget/category_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryListWidget extends StatelessWidget {
  final String gender;
  final List<ProductModel> products;
  const CategoryListWidget({
    super.key,
    required this.gender,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    List<ProductsListType> productsList = [
      ProductsListType.New,
      ProductsListType.Clothes,
      ProductsListType.Shoes,
      ProductsListType.Accesories,
    ];
    List<String> imageList = [
      "assets/images/New.png",
      "assets/images/Clothes.png",
      "assets/images/Shoes.png",
      "assets/images/Accesories.png",
    ];
    return ListView.builder(
      itemCount: productsList.length,
      itemBuilder: (context, index) {
        final catTypesSet = <String>{};
        for (var product in products.where((element) =>element.productCategory == productsList[index].name,).toList()) {
          catTypesSet.add(product.catType);
        }
        return CategoryItem(
          catImage: imageList[index],
          gender: gender,
          catName: productsList[index].name,
          products:productsList[index].name == "New" ?products.where((product) {
            final now = DateTime.now();
            final createdDate = product.createdAt.toDate();
            final difference = now.difference(createdDate).inDays;
            return difference <= 7;
          }).toList():products
              .where(
                (element) =>
                    element.productCategory == productsList[index].name ,
              )
              .toList(),
          catTypesList: catTypesSet.toList(),
        );
      },
    );
  }
}
