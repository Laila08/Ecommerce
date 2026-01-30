import 'package:ecommerceapp/core/services/auth_services.dart';
import 'package:ecommerceapp/core/services/cart_services.dart';
import 'package:ecommerceapp/core/services/favorite_services.dart';
import 'package:ecommerceapp/core/services/product_details_services.dart';
import 'package:ecommerceapp/core/models/cart_model.dart';
import 'package:ecommerceapp/core/models/product_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../utils/constants.dart';

part 'product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  ProductDetailsCubit() : super(ProductDetailsInitial());
  final productDetailsServices = ProductDetailsServicesImp();
  final cartServices = CartServicesImpl();
  final authServices = AuthServicesImp();
  final favoriteServices = FavoriteServicesImp();
  String? size;
  String? color;

  Future<void> getProductDetails(String productId) async {
    if (isClosed) return;
    emit(ProductDetailsLoading());
    try {
      final product = await productDetailsServices.getProductDetails(productId);
      if (isClosed) return;
      emit(ProductDetailsLoaded(product));
    } catch (e) {
      if (isClosed) return;
      emit(ProductDetailsError(e.toString()));
    }
  }

  void setSize(String newSize) {
    size = newSize;
    emit(SizeSelected(newSize));
  }

  void setColor(String newColor) {
    color = newColor;
    emit(ColorSelected(newColor));
  }

  Future<void> addToCart(ProductModel product) async {
    if (isClosed) return;
    emit(AddingToCart());
    try {
      final currentUser = authServices.currentUser;
      if (size == null && color == null) {
        if (isClosed) return;
        emit(AddToCartError('Please select a size and a color'));
        return;
      } else if (size == null) {
        if (isClosed) return;
        emit(AddToCartError('Please select a size'));
        return;
      } else if (color == null) {
        if (isClosed) return;
        emit(AddToCartError('Please select a color'));
        return;
      }
      final newProduct = CartModel(
          cartId: documentidFromLocalData(),
          productName: product.productName,
          productPrice: product.productPrice,
          productId: product.productId,
          productImage: product.productImage,
          size: size!,
          color: color!,
          createdAt: product.createdAt
      );
      await cartServices.addProductToCart(currentUser!.uid, newProduct);
      if (isClosed) return;
      emit(AddedToCart());
    } catch (e) {
      if (isClosed) return;
      emit(AddToCartError(e.toString()));
    }
  }
}