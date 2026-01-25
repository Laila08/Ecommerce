import 'dart:async';

import 'package:ecommerceapp/core/services/auth_services.dart';
import 'package:ecommerceapp/core/services/cart_services.dart';
import 'package:ecommerceapp/core/models/cart_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial()){
  listenToCart(); // 👈 هنا يبدأ الاستماع تلقائياً عند إنشاء الكوبت
  }
  final cartServices = CartServicesImpl();
  final authServices = AuthServicesImp();
  StreamSubscription<List<CartModel>>? _cartSub;
  void listenToCart() {
    final user = authServices.currentUser;
    if (user == null) return;

    _cartSub?.cancel(); // safety
    _cartSub = cartServices.cartStream(user.uid).listen((cartProducts) {
      emit(CartISuccess(
        cartProducts: cartProducts,
        totalPrice: _calculateTotal(cartProducts),
      ));
    });
  }

  Future<void> removeFromCarts(CartModel product) async {
    print('🟡 removeFromCarts CALLED with cartId=${product.cartId}');
    print('🟡 current state before delete = ${state.runtimeType}');

    final currentState = state as CartISuccess;
    final user = authServices.currentUser;
    print('🟡 currentUser uid = ${user?.uid}');

    try {
      print('🟡 deleting from Firebase...');
      await cartServices.removeFromCarts(user!.uid, product.productId);
      print('🟢 Firebase delete DONE');

      final updatedProducts = currentState.cartProducts
          .where((item) => item.cartId != product.cartId)
          .toList();
      print('🟡 before delete length = ${currentState.cartProducts.length}');
      print('🟢 after delete length = ${updatedProducts.length}');

      if (isClosed) return;
      print('🟢 emitting CartISuccess...');

      emit(
        CartISuccess(
          cartProducts: updatedProducts,
          totalPrice: _calculateTotal(updatedProducts),
        ),
      );
      print('🟢 emit DONE');

    } catch (e) {
      if (isClosed) return;
      emit(CartIFailed(e.toString()));
    }
  }

  Future<void> getCartProducts() async {
    if (isClosed) return;
    emit(CartILoading());
    try {
      final user = authServices.currentUser;
      final cartProducts = await cartServices.getCartProducts(user!.uid);
      if (isClosed) return;
      emit(
        CartISuccess(
          cartProducts: cartProducts,
          totalPrice: _calculateTotal(cartProducts),
        ),
      );
    } catch (e) {
      if (isClosed) return;
      emit(CartIFailed(e.toString()));
    }
  }

  void addQuantity(CartModel product) {
    if (state is! CartISuccess) return;

    final currentState = state as CartISuccess;

    final updatedProducts = currentState.cartProducts.map((item) {
      if (item.cartId == product.cartId) {
        return item.copyWith(quantity: item.quantity + 1);
      }
      return item;
    }).toList();

    emit(
      CartISuccess(
        cartProducts: updatedProducts,
        totalPrice: _calculateTotal(updatedProducts),
      ),
    );
  }

  void oddQuantity(CartModel product) {
    if (state is! CartISuccess) return;

    final currentState = state as CartISuccess;

    final updatedProducts = currentState.cartProducts.map((item) {
      if (item.cartId == product.cartId) {
        final newQuantity = item.quantity > 1 ? item.quantity - 1 : 1;
        return item.copyWith(quantity: newQuantity);
      }
      return item;
    }).toList();

    emit(
      CartISuccess(
        cartProducts: updatedProducts,
        totalPrice: _calculateTotal(updatedProducts),
      ),
    );
  }

  double _calculateTotal(List<CartModel> products) {
    double total = 0;
    for (final item in products) {
      total += item.productPrice * item.quantity;
    }
    return total;
  }
}