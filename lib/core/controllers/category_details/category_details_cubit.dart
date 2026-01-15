import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../models/product_model.dart';

part 'category_details_state.dart';

class CategoryDetailsCubit extends Cubit<CategoryDetailsState> {
  CategoryDetailsCubit(List<ProductModel> products)
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
