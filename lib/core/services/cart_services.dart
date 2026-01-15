import 'package:ecommerceapp/core/models/cart_model.dart';
import 'package:ecommerceapp/core/models/product_model.dart';

import '../utils/api_path.dart';
import 'firestore_services.dart';

abstract class CartServices {
  Future<void> addProductToCart(String userId,CartModel cartProduct);
  Future<List<CartModel>> getCartProducts(String userId);
  Future<void> addProductToFavorite(String userId, ProductModel product);
  Future<void> removeFromCarts(String userId, String productId);
}

class CartServicesImpl implements CartServices{
  final _services = FirestoreServices.instance;
  @override
  Future<void> removeFromCarts(String userId, String productId) async =>
      await _services.deleteData(path: ApiPath.carts(userId, productId));
  @override
  Future<void> addProductToCart(String userId, CartModel cartProduct)async => await _services.setData(
    path: ApiPath.carts(userId, cartProduct.productId),
    data: cartProduct.toMap(),
  );

  @override
  Future<List<CartModel>> getCartProducts(String userId) async => await _services.getCollection(
    path: ApiPath.productsCart(userId),
    builder: (data, documentId) => CartModel.fromMap(data, documentId),
  );

  @override
  Future<void> addProductToFavorite(String userId, ProductModel product)async => await _services.setData(
    path: ApiPath.favorites(userId, product.productId),
    data: product.toMap(),
  );
}