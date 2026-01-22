import 'dart:async';

import 'package:ecommerceapp/core/models/cart_model.dart';
import 'package:ecommerceapp/core/services/auth_services.dart';
import 'package:ecommerceapp/core/services/favorite_services.dart';
import 'package:ecommerceapp/core/models/product_model.dart';
import 'package:ecommerceapp/core/services/home_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../sort/sort_cubit.dart';

part 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  final SortCubit sortCubit = SortCubit();
  late final StreamSubscription<int> _sortSubscription;
  FavoriteCubit() : super(FavoriteInitial()) {
    _sortSubscription = sortCubit.stream.listen((_) {
      final currentState = state;
      if (currentState is FavoriteSuccess) {
        emit(
          FavoriteSuccess(
            favoriteProducts: currentState.favoriteProducts,
            catTypes: currentState.catTypes,
            selectedCatType: currentState.selectedCatType,
          ),
        );
      }
    });
  }
  final authServices = AuthServicesImp();
  final favoriteServices = FavoriteServicesImp();
  final homeServices = HomeServicesImp();

  Future<void> getFavorites() async {
    emit(FavoriteLoading());
    try {
      final currentUser = authServices.currentUser;
      final favorites = await favoriteServices.getFavorites(currentUser!.uid);
      emit(
        FavoriteSuccess(
          favoriteProducts: favorites,
          catTypes: _buildCatTypes(favorites),
          selectedCatType: null,
        ),
      );
    } catch (e) {
      emit(FavoriteFailed(e.toString()));
    }
  }
  @override
  Future<void> close() {
    _sortSubscription.cancel();
    return super.close();
  }
  List<ProductModel> get sortedProducts {
    final currentState = state;
    if (currentState is! FavoriteSuccess) return [];

    List<ProductModel> products =
    currentState.selectedCatType == null
        ? List.from(currentState.favoriteProducts)
        : currentState.favoriteProducts
        .where((p) => p.catType == currentState.selectedCatType)
        .toList();

    switch (sortCubit.state) {
      case 1:
        products.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        break;
      case 2:
        products.sort(
              (a, b) =>
              (b.productRate ?? 0).compareTo(a.productRate ?? 0),
        );
        break;
      case 3:
        products.sort(
              (a, b) => a.productPrice.compareTo(b.productPrice),
        );
        break;
      case 4:
        products.sort(
              (a, b) => b.productPrice.compareTo(a.productPrice),
        );
        break;
    }
    return products;
  }

  void clearSelectedCatType() {
    final currentState = state;
    if (currentState is FavoriteSuccess) {
      emit(
        FavoriteSuccess(
          favoriteProducts: currentState.favoriteProducts,
          catTypes: currentState.catTypes,
          selectedCatType: null,
        ),
      );
    }
  }

  void selectCatType(String? catType) {
    final currentState = state;
    if (currentState is FavoriteSuccess) {
      emit(
        FavoriteSuccess(
          favoriteProducts: currentState.favoriteProducts,
          catTypes: currentState.catTypes,
          selectedCatType: catType,
        ),
      );
    }
  }

  Future<void> addToFavorite(CartModel cartProduct) async {
    final userId = authServices.currentUser!.uid;
    final currentState = state;
    final allProduct = await homeServices.getAllProduct();
    final myProductList = allProduct
        .where((element) => element.productId == cartProduct.productId)
        .toList();
    if (myProductList.isEmpty) return;
    final product = myProductList.first;
    if (currentState is FavoriteSuccess) {
      final favorites = List<ProductModel>.from(currentState.favoriteProducts);
      final exists = favorites.any(
        (p) => p.productId == product.productId,
      );
      if(!exists){
        final updatedFavorites = List<ProductModel>.from(
          currentState.favoriteProducts,
        )..add(product);
        emit(
          FavoriteSuccess(
            favoriteProducts: updatedFavorites,
            catTypes: _buildCatTypes(updatedFavorites),
            selectedCatType: currentState.selectedCatType,
          ),
        );
      }

      try {
        await favoriteServices.addToFavorite(userId, cartProduct);
      } catch (e) {
        emit(
          FavoriteSuccess(
            favoriteProducts: currentState.favoriteProducts,
            catTypes: _buildCatTypes(currentState.favoriteProducts),
            selectedCatType: currentState.selectedCatType,
          ),
        );
      }
    }
  }

  Future<void> toggleFavorite(ProductModel product) async {
    final userId = authServices.currentUser!.uid;
    final currentState = state;

    if (currentState is FavoriteSuccess) {
      List<ProductModel> updatedFavorites = List.from(
        currentState.favoriteProducts,
      );
      final exists = updatedFavorites.any(
        (p) => p.productId == product.productId,
      );
      if (exists) {
        updatedFavorites.removeWhere((p) => p.productId == product.productId);
      } else {
        updatedFavorites.add(product);
      }
      emit(
        FavoriteSuccess(
          favoriteProducts: updatedFavorites,
          catTypes: _buildCatTypes(updatedFavorites),
          selectedCatType: null,
        ),
      );
      try {
        await favoriteServices.toggleFavorite(userId, product);
      } catch (e) {
        emit(
          FavoriteSuccess(
            favoriteProducts: currentState.favoriteProducts,
            catTypes: _buildCatTypes(updatedFavorites),
            selectedCatType: null,
          ),
        );
      }
    } else {
      await getFavorites();
    }
  }

  List<String> _buildCatTypes(List<ProductModel> products) {
    return products.map((e) => e.catType).toSet().toList();
  }
}
