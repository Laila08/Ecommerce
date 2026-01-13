// import 'package:ecommerceapp/core/utils/api_path.dart';
// import 'package:ecommerceapp/features/auth/data/cart_model.dart';
// import 'package:ecommerceapp/features/auth/data/user_model.dart';
// import 'package:ecommerceapp/features/auth/data/product_model.dart';
// import 'package:flutter/cupertino.dart';
//
// import '../services/firestore_services.dart';
//
// abstract class DataBase {
//   Stream<List<CartModel>> productsCartStream();
//   Future<void> setUserData(UserModel user);
//   Future<void> addToCart(CartModel product);
// }
//
// //String get documentId => DateTime.now().toIso8601String();
//
// class FireStoreDatabase implements DataBase {
//   final String uid;
//
//   FireStoreDatabase(this.uid);
//   final _services = FirestoreServices.instance;
//
//   @override
//   Future<void> setUserData(UserModel user) async {
//     await _services.setData(
//       path: ApiPath.users(user.uid),
//       data: user.toMap(),
//     );
//   }
//
//   @override
//   Future<void> addToCart(CartModel product) async {
//     return _services.setData(
//       path: ApiPath.carts(uid, product.productId),
//       data: product.toMap(),
//     );
//     debugPrint("done");
//   }
//
//   @override
//   Stream<List<CartModel>> productsCartStream() {
//     return _services.collectionStream(
//       path: ApiPath.productsCart(uid),
//       builder: (data, documentId) => CartModel.fromMap(data!, documentId),
//     );
//   }
// }
