part of 'cart_cubit.dart';

@immutable
sealed class CartState {}

final class CartInitial extends CartState {}
final class CartILoading extends CartState {}

final class CartISuccess extends CartState {
  final List<CartModel> cartProducts;
  final double totalPrice;
  CartISuccess({required this.cartProducts, required this.totalPrice});
}

final class CartIFailed extends CartState {
  final String error;
  CartIFailed(this.error);
}