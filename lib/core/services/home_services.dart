import 'package:ecommerceapp/core/utils/api_path.dart';
import 'package:ecommerceapp/core/models/product_model.dart';
import 'package:ecommerceapp/core/models/user_model.dart';

import 'firestore_services.dart';

abstract class HomeServices {
  Future<List<ProductModel>> getAllProduct();
  Future<List<ProductModel>> getSalesProduct();

  Future<void> setUserData(UserModel user);
  Future<List<ProductModel>> getFilteredProducts({
    required String category,
    required String gender,
  });
  Future<List<String>> getCatTypes({
    required String gender,
    required String productCategory,
  });
  Future<List<ProductModel>> getFilteredCat({
    required String category,
    required String gender,
    required String type,
  });
  Future<List<String>> getCatTypesFromFav({
    required String gender,
    required String productCategory,
    required String uid,
    required String productId
  });
}

class HomeServicesImp implements HomeServices {
  final _services = FirestoreServices.instance;
  HomeServicesImp();
  @override
  Future<List<String>> getCatTypesFromFav({
    required String gender,
    required String productCategory,
    required String uid,
    required String productId
  }) async {
    final products = await _services.getCollection(
      path: ApiPath.favorites(uid, productId),
      builder: (data, documentId) => ProductModel.fromMap(data, documentId),
      queryBuilder: (query) => query
          .where('gender', isEqualTo: gender)
          .where('productCategory', isEqualTo: productCategory),
    );
    final catTypesSet = <String>{};
    for (var product in products) {
      catTypesSet.add(product.catType);
    }
    return catTypesSet.toList();
  }
  @override
  Future<List<ProductModel>> getAllProduct() async =>
      await _services.getCollection(
        path: ApiPath.products(),
        builder: (data, documentId) => ProductModel.fromMap(data, documentId),
      );

  @override
  Future<void> setUserData(UserModel user) async {
    await _services.setData(path: ApiPath.users(user.uid), data: user.toMap());
  }

  @override
  Future<List<ProductModel>> getSalesProduct() async =>
      await _services.getCollection(
        path: ApiPath.products(),
        builder: (data, documentId) => ProductModel.fromMap(data, documentId),
        queryBuilder: (query) =>
            query.where('productDiscount', isGreaterThan: 0),
      );

  @override
  Future<List<ProductModel>> getFilteredProducts({
    required String category,
    required String gender,
  }) async => await _services.getCollection(
    path: ApiPath.products(),
    builder: (data, documentId) => ProductModel.fromMap(data, documentId),
    queryBuilder: (query) => query
        .where('gender', isEqualTo: gender)
        .where('category_details', isEqualTo: category),
  );
  @override
  Future<List<ProductModel>> getFilteredProductsByGender({
    required String gender,
  }) async => await _services.getCollection(
    path: ApiPath.products(),
    builder: (data, documentId) => ProductModel.fromMap(data, documentId),
    queryBuilder: (query) => query.where('gender', isEqualTo: gender),
  );
  @override
  Future<List<String>> getCatTypes({
    required String gender,
    required String productCategory,
  }) async {
    final products = await _services.getCollection(
      path: ApiPath.products(),
      builder: (data, documentId) => ProductModel.fromMap(data, documentId),
      queryBuilder: (query) => query
          .where('gender', isEqualTo: gender)
          .where('productCategory', isEqualTo: productCategory),
    );
    final catTypesSet = <String>{};
    for (var product in products) {
      catTypesSet.add(product.catType);
    }
    return catTypesSet.toList();
  }

  @override
  Future<List<ProductModel>> getFilteredCat({
    required String category,
    required String gender,
    required String type,
  }) async => await _services.getCollection(
    path: ApiPath.products(),
    builder: (data, documentId) => ProductModel.fromMap(data, documentId),
    queryBuilder: (query) => query
        .where('gender', isEqualTo: gender)
        .where('catType', isEqualTo: type)
        .where('category_details', isEqualTo: category),
  );

}
