

import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  final String productId;
  final String productImage;
  final String productName;
  final int productPrice;
  final String productCategory;
  final String catType;
  final String gender;
  final int? productDiscount;
  final int? productRate;
  final Timestamp createdAt;
  final String desc;

  ProductModel({
    required this.productImage,
    required this.productName,
    required this.productPrice,
    this.productCategory = 'Other',
    this.productDiscount,
    this.productRate,
    required this.productId,
    required this.createdAt,
    required this.gender,
    this.catType = 'T-shirts',
    this.desc ='There is no description'
  });

  Map<String, dynamic> toMap() {
    return {
      'productImage': productImage,
      'productName': productName,
      'productPrice': productPrice,
      'productCategory': productCategory,
      'catType': catType,
      'gender': gender,
      'productDiscount': productDiscount?? 0,
      'productRate': productRate?? 0,
      'createdAt':createdAt,
      'desc':desc
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map, String id) {
    return ProductModel(
      productImage: map['productImage'] as String,
      productName: map['productName'] as String,
      productPrice: map['productPrice'] as int,
      productCategory: map['productCategory'] as String? ?? 'Other',
      catType: map['catType'] as String? ??'T-shirts',
      productDiscount: map['productDiscount'] != null ? map['productDiscount'] as int : 0,
      productRate: map['productRate'] != null ? map['productRate'] as int : 0,
      productId: id,
      createdAt: map['createdAt'] as Timestamp,
      gender: map['gender'] as String? ??'Unisex',
        desc:map['desc'] as String? ??'There is no description'
    );
  }

  ProductModel copyWith({
    String? productId,
    String? productImage,
    String? productName,
    int? productPrice,
    String? productCategory,
    String? catType,
    String? gender,
    int? productDiscount,
    int? productRate,
    Timestamp? createdAt
  }) {
    return ProductModel(
      productId: productId ?? this.productId,
      productImage: productImage ?? this.productImage,
      productName: productName ?? this.productName,
      productPrice: productPrice ?? this.productPrice,
      productCategory: productCategory ?? this.productCategory,
      productDiscount: productDiscount ?? this.productDiscount,
      productRate: productRate ?? this.productRate,
      createdAt: createdAt ?? this.createdAt,
      gender: gender ?? this.gender,
      catType: catType ?? this.catType,
    );
  }
}
//
// class ProductModel {
//   final String productId;
//   final String productImage;
//   final String productName;
//   final int productPrice;
//   final String productCategory;
//   final String catType;
//   final String gender;
//   final int? productDiscount;
//   final int? productRate;
//   final Timestamp? createdAt;
//
//   ProductModel({
//     required this.productImage,
//     required this.productName,
//     required this.productPrice,
//     this.productCategory = 'Other',
//     this.productDiscount,
//     this.productRate,
//     required this.productId,
//     this.createdAt,
//     required this.gender,
//     this.catType = 'T-shirts',
//   });
//
//   Map<String, dynamic> toMap() {
//     return {
//       'productImage': productImage,
//       'productName': productName,
//       'productPrice': productPrice,
//       'productCategory': productCategory,
//       'catType': catType,
//       'gender': gender,
//       'productDiscount': productDiscount?? 0,
//       'productRate': productRate?? 0,
//       'createdAt':createdAt??Timestamp.now(),
//     };
//   }
//
//   factory ProductModel.fromMap(Map<String, dynamic> map, String id) {
//     return ProductModel(
//       productImage: map['productImage'] as String,
//       productName: map['productName'] as String,
//       productPrice: map['productPrice'] as int,
//       productCategory: map['productCategory'] as String? ?? 'Other',
//       catType: map['catType'] as String? ??'T-shirts',
//       productDiscount: map['productDiscount'] != null ? map['productDiscount'] as int : 0,
//       productRate: map['productRate'] != null ? map['productRate'] as int : 0,
//       productId: id,
//       createdAt: map['createdAt'] as Timestamp? ??Timestamp.now(),
//       gender: map['gender'] as String? ??'Unisex',
//     );
//   }
//
//   ProductModel copyWith({
//     String? productId,
//     String? productImage,
//     String? productName,
//     int? productPrice,
//     String? productCategory,
//     String? catType,
//     String? gender,
//     int? productDiscount,
//     int? productRate,
//     Timestamp? createdAt
//   }) {
//     return ProductModel(
//       productId: productId ?? this.productId,
//       productImage: productImage ?? this.productImage,
//       productName: productName ?? this.productName,
//       productPrice: productPrice ?? this.productPrice,
//       productCategory: productCategory ?? this.productCategory,
//       productDiscount: productDiscount ?? this.productDiscount,
//       productRate: productRate ?? this.productRate,
//       createdAt: createdAt ?? this.createdAt,
//       gender: gender ?? this.gender,
//       catType: catType ?? this.catType,
//     );
//   }
// }