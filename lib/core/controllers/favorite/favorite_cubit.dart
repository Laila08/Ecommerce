import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceapp/core/controllers/home/home_cubit.dart';
import 'package:ecommerceapp/core/models/cart_model.dart';
import 'package:ecommerceapp/core/services/auth_services.dart';
import 'package:ecommerceapp/core/services/cart_services.dart';
import 'package:ecommerceapp/core/services/favorite_services.dart';
import 'package:ecommerceapp/core/models/product_model.dart';
import 'package:ecommerceapp/core/services/home_services.dart';
import 'package:meta/meta.dart';

part 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit() : super(FavoriteInitial());
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
