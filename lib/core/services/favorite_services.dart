import 'package:ecommerceapp/core/models/cart_model.dart';
import 'package:ecommerceapp/core/services/firestore_services.dart';
import 'package:ecommerceapp/core/utils/api_path.dart';
import 'package:ecommerceapp/core/models/product_model.dart';

abstract class FavoriteServices {
  Future<List<ProductModel>> getFavorites(String userId);
  Future<void> removeFromFavorites(String userId, String productId);
  Future<void> toggleFavorite(String userId, ProductModel product);
  Future<void> addToFavorite(String userId, CartModel product);
}

class FavoriteServicesImp implements FavoriteServices {
  final _services = FirestoreServices.instance;

  @override
  Future<List<ProductModel>> getFavorites(String userId) async =>
      await _services.getCollection(
        path: ApiPath.favoriteProducts(userId),
        builder: (data, documentID) => ProductModel.fromMap(data, documentID),
      );

  @override
  Future<void> removeFromFavorites(String userId, String productId) async =>
      await _services.deleteData(path: ApiPath.favorites(userId, productId));
  @override
  Future<void> addToFavorite(String userId, CartModel product) async {
    final path = ApiPath.favorites(userId, product.productId);
    await _services.setData(
        path: path,
        data: product.toMap(),
      );
  }
  @override
  Future<void> toggleFavorite(String userId, ProductModel product) async {
    final path = ApiPath.favorites(userId, product.productId);
    try {
      await _services.getDocument(
        path: path,
        builder: (data, id) => data,
      );
      await _services.deleteData(path: path);
    } catch (e) {
      await _services.setData(
        path: path,
        data: product.toMap(),
      );
    }
  }

}
