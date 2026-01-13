import 'package:bloc/bloc.dart';
import 'package:ecommerceapp/core/controllers/home/home_cubit.dart';
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
      emit(FavoriteSuccess(favoriteProducts: favorites, catTypes:_buildCatTypes(favorites), selectedCatType: null,));
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
      emit(FavoriteSuccess(favoriteProducts: updatedFavorites, catTypes:_buildCatTypes(updatedFavorites), selectedCatType:null,));
      try {
        await favoriteServices.toggleFavorite(userId, product);
      } catch (e) {
        emit(FavoriteSuccess(favoriteProducts: currentState.favoriteProducts, catTypes: _buildCatTypes(updatedFavorites), selectedCatType:null));
      }
    } else {
      await getFavorites();
    }
  }
  List<String> _buildCatTypes(List<ProductModel> products) {
    return products.map((e) => e.catType).toSet().toList();
  }

}
