import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../models/product_model.dart';
import '../../utils/products_list_type.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit({
    required List<ProductModel> men,
    required List<ProductModel> women,
    required List<ProductModel> kids,
  }) : super(CategoryInitial()) {
    _menProducts = men;
    _womenProducts = women;
    _kidsProducts = kids;

    emit(CategoryLoaded());
  }

  late final List<ProductModel> _menProducts;
  late final List<ProductModel> _womenProducts;
  late final List<ProductModel> _kidsProducts;

  List<ProductModel> getProductsByGender(String gender) {
    switch (gender) {
      case 'Men':
        return _menProducts;
      case 'Women':
        return _womenProducts;
      case 'Kids':
        return _kidsProducts;
      default:
        return [];
    }
  }

  List<ProductModel> getProductsByCategory(
      String gender,
      ProductsListType category,
      ) {
    final products = getProductsByGender(gender);

    if (category == ProductsListType.New) {
      return _getNewProducts(products);
    }
    return products
        .where((e) => e.productCategory == category.name)
        .toList();
  }

  List<String> getCatTypes(
      String gender,
      ProductsListType category,
      ) {
    return getProductsByCategory(gender, category)
        .map((e) => e.catType)
        .toSet()
        .toList();
  }

  List<ProductModel> _getNewProducts(List<ProductModel> products) {
    final now = DateTime.now();
    return products.where((product) {
      final createdDate = product.createdAt.toDate();
      return now.difference(createdDate).inDays <= 7;
    }).toList();
  }
}
