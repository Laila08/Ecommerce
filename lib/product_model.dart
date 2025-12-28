import 'package:ecommerceapp/core/utils/products_list_type.dart';

class ProductModel {
  final String productId;
  final String productImage;
  final String productName;
  final int productPrice;
  final String productCategory;
  final int? productDiscount;
  final int? productRate;

  ProductModel({
    required this.productImage,
    required this.productName,
    required this.productPrice,
    this.productCategory ='Other',
    this.productDiscount,
    this.productRate,
    required this.productId,
  });

  Map<String, dynamic> toMap() {
    return {
      'productImage': productImage,
      'productName': productName,
      'productPrice': productPrice,
      'productCategory':productCategory,
      'productDiscount': productDiscount,
      'productRate': productRate,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map , String id) {
    return ProductModel(
      productImage: map['productImage'] as String,
      productName: map['productName'] as String,
      productPrice: map['productPrice'] as int,
      productCategory: map['productCategory'] as String,
      productDiscount: map['productDiscount'] as int,
      productRate: map['productRate'] as int,
      productId:id,
    );
  }
}
