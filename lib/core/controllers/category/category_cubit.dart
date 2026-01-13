import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../models/product_model.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit(List<ProductModel> products)
      : super(CategoryInitial()) {
    currentProducts = products;
    emit(CategoryLoaded());
  }

  List<ProductModel> currentProducts = [];
  List<ProductModel>? filteredProducts;
  String? selectedCatType;

  void filterByCatType(String type) {
    selectedCatType = type;
    filteredProducts =
        currentProducts.where((p) => p.catType == type).toList();
    emit(CategoryFiltered());
  }

  void clearFilter() {
    filteredProducts = null;
    selectedCatType = null;
    emit(CategoryFiltered());
  }
}
