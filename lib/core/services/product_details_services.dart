
import 'package:ecommerceapp/core/services/firestore_services.dart';
import 'package:ecommerceapp/core/utils/api_path.dart';
import 'package:ecommerceapp/core/models/product_model.dart';

abstract class ProductDetailsServices {
  Future<ProductModel> getProductDetails(String productId);
}

class ProductDetailsServicesImp implements ProductDetailsServices {
  final _services = FirestoreServices.instance;

  @override
  Future<ProductModel> getProductDetails(String productId) async =>
      await _services.getDocument(
        path: ApiPath.product(productId),
        builder: (data, documentId) => ProductModel.fromMap(data, documentId),
      );
}
