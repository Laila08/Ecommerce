import '../../../models/product_model.dart';
import '../../../utils/products_list_type.dart';

class CategoryProductsHelper {
  static List<ProductModel> getProductsByCategory(
      List<ProductModel> products,
      ProductsListType category,
      ) {
    if (category.name == 'New') {
      return _getNewProducts(products);
    }
    return products
        .where((e) => e.productCategory == category.name)
        .toList();
  }

  static List<String> getCategoryTypes(
      List<ProductModel> products,
      ProductsListType category,
      ) {
    return products
        .where((e) => e.productCategory == category.name)
        .map((e) => e.catType)
        .toSet()
        .toList();
  }

  static List<ProductModel> _getNewProducts(List<ProductModel> products) {
    final now = DateTime.now();
    return products.where((product) {
      final createdDate = product.createdAt.toDate();
      return now.difference(createdDate).inDays <= 7;
    }).toList();
  }

}
