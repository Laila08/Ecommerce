import 'package:ecommerceapp/core/utils/api_path.dart';
import 'package:ecommerceapp/product_model.dart';

import '../services/firestore_services.dart';

abstract class DataBase {
  Stream<List<ProductModel>> productsStream();
  Stream<List<ProductModel>> salesProductsStream();
  Future<void> setProduct(ProductModel product);
}
String get documentId => DateTime.now().toIso8601String();
class FireStoreDatabase implements DataBase {
  final String uid;
  FireStoreDatabase(this.uid);
  final _services = FirestoreServices.instance;
  @override
  Stream<List<ProductModel>> productsStream() {
    return _services.collectionStream(
      path: (ApiPath.products()),
      builder: (data, documentId) => ProductModel.fromMap(data!, documentId),
    );
  }

  @override
  Stream<List<ProductModel>> salesProductsStream() {
    return _services.collectionStream(
      path: (ApiPath.products()),
      builder: (data, documentId) => ProductModel.fromMap(data!, documentId),
      queryBuilder: (query) => query.where('productDiscount', isGreaterThan: 0),
    );
  }

  @override
  Future<void> setProduct(ProductModel product) async {
    await _services.setData(
      path: "${ApiPath.products()}${product.productId}",
      data: product.toMap(),
    );
  }
}
