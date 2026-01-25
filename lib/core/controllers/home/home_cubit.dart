import 'package:ecommerceapp/core/services/home_services.dart';
import 'package:ecommerceapp/core/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  List<ProductModel> currentProducts = [];
  List<ProductModel>? filteredProducts;
  String? selectedCatType;


  void setCurrentProducts(List<ProductModel> products) {
    currentProducts = products;
    filteredProducts = null;
    selectedCatType = null;
    emit(FilteredSuccess());
  }

  void filterByCatType(String catType) {
    selectedCatType = catType;
    filteredProducts = currentProducts
        .where((p) => p.catType == catType)
        .toList();
    emit(FilteredSuccess());
  }

  void clearFilter() {
    filteredProducts = null;
    selectedCatType = null;
    emit(FilteredSuccess());
  }

  final homeServices = HomeServicesImp();
  Future<List<String>> getCatTypes(String cat, String gender) async {
    try {
      final catTypesList = await homeServices.getCatTypes(
        gender: gender,
        productCategory: cat,
      );
      return catTypesList;
    } catch (e) {
      return [];
    }
  }

  Future<void> getHomeProducts() async {
    if (isClosed) return;
    emit(HomeLoading());
    try {
      final now = DateTime.now();
      final allProducts = await homeServices.getAllProduct();
      final salesProducts = await homeServices.getSalesProduct();

      final newProducts = allProducts.where((product) {
        final now = DateTime.now();
        final createdDate = product.createdAt.toDate();
        final difference = now.difference(createdDate).inDays;
        return difference <= 7;
      }).toList();
      final menProducts = await homeServices.getFilteredProductsByGender(
        gender: "Men",
      );
      final womenProducts = await homeServices.getFilteredProductsByGender(
        gender: "Women",
      );
      final kidsProducts = await homeServices.getFilteredProductsByGender(
        gender: "Kids",
      );
      final newMenProduct = getNewProducts(menProducts, "Men", now);
      final newWomenProduct = getNewProducts(womenProducts, "Women", now);
      final newKidsProduct = getNewProducts(kidsProducts, "Kids", now);
      if (isClosed) return;
      emit(
        HomeSuccess(
          salesProducts: salesProducts,
          newProducts: newProducts,
          menProducts: menProducts,
          womenProducts: womenProducts,
          kidsProducts: kidsProducts,
          newKidsProduct:newKidsProduct,
          newWomenProduct: newWomenProduct,
          newMenProduct:newMenProduct,
        ),
      );
    } catch (e) {
      if (isClosed) return;
      emit(HomeFailed(e.toString()));
    }
  }

  List<ProductModel> getNewProducts(
    List<ProductModel> allProducts,
    String gender,
    DateTime now,
  ) {
    return allProducts.where((product) {
      final createdDate = product.createdAt.toDate();
      final difference = now.difference(createdDate).inDays;
      return difference <= 7 && product.gender == gender;
    }).toList();
  }
}
