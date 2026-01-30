import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../models/product_model.dart';
import '../sort/sort_cubit.dart';

part 'category_details_state.dart';

class CategoryDetailsCubit extends Cubit<CategoryDetailsState> {
  final SortCubit sortCubit = SortCubit();
  late final StreamSubscription<int> _sortSubscription;

  CategoryDetailsCubit(List<ProductModel> products) : super(CategoryInitial()) {
    currentProducts = products;
    _sortSubscription = sortCubit.stream.listen((_) {
      emit(CategorySorted());
    });
    emit(CategoryLoaded());
  }

  List<ProductModel> currentProducts = [];
  List<ProductModel>? filteredProducts;
  String? selectedCatType;
  @override
  Future<void> close() {
    _sortSubscription.cancel();
    return super.close();
  }

  void filterByCatType(String type) {
    selectedCatType = type;
    filteredProducts = currentProducts.where((p) => p.catType == type).toList();
    emit(CategoryFiltered());
  }

  List<ProductModel> get sortedProducts {
    final products = List<ProductModel>.from(
      filteredProducts ?? currentProducts,
    );

    switch (sortCubit.state) {
      case 1:
        products.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        break;
      case 2:
        products.sort(
          (a, b) => b.productRate ?? 0.compareTo(a.productRate ?? 0),
        );
        break;
      case 3:
        products.sort((a, b) => a.productPrice.compareTo(b.productPrice));
        break;
      case 4:
        products.sort((a, b) => b.productPrice.compareTo(a.productPrice));
        break;
    }
    return products;
  }

  void clearFilter() {
    filteredProducts = null;
    selectedCatType = null;
    emit(CategoryFiltered());
  }
}
