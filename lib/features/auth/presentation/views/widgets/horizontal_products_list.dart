import 'package:ecommerceapp/core/extensions/app_extentions.dart';
import 'package:ecommerceapp/core/utils/products_list_type.dart';
import 'package:ecommerceapp/product_model.dart';
import 'package:flutter/material.dart';

import 'product_item.dart';

class HorizontalProductsList extends StatelessWidget {
  final Color color;
  final ProductsListType listType;
  final Stream<List<ProductModel>> productsStreamtype;
  const HorizontalProductsList({super.key,required this.color, required this.listType,required this.productsStreamtype});

  @override
  Widget build(BuildContext context) {
    final heigh = context.heigh;
    return SizedBox(
      height: heigh*0.36,
      child: StreamBuilder<List<ProductModel>>(
        stream: productsStreamtype,
        builder: (_, asyncSnapshot) {
          if (asyncSnapshot.connectionState == ConnectionState.active) {
            final products = asyncSnapshot.data;
            if (!asyncSnapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            if (products!.isEmpty) {
              return const Center(child: Text("No products"));
            }
            return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: products.length,
                    itemBuilder: (BuildContext context, int index) =>
                        ProductItem(
                          product: products[index],
                          color: color, listType: listType,
                        ),
                  );
          }return Center(child:CircularProgressIndicator());
        },
      ),
    );
  }
}
