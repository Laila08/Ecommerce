part of 'checkout_cubit.dart';

@immutable
sealed class CheckoutState {}
//------------------------------- DeliveryMethods -----------------------------
final class DeliveryMethodInitial extends CheckoutState {}

final class DeliveryMethodLoading extends CheckoutState {}

final class DeliveryMethodLoaded extends CheckoutState {
  final List<DeliveryMethodModel> deliveryMethods;
  final DeliveryMethodModel? selectedMethod;
  final ShippingAddressModel? shippingAddress;
  final double orderPrice;
  final double totalAmount;
  DeliveryMethodLoaded({
    required this.deliveryMethods,
    required this.orderPrice,
    required this.totalAmount,
    this.shippingAddress,
    this.selectedMethod,
  });
}

final class DeliveryMethodFailed extends CheckoutState {
  final String error;

  DeliveryMethodFailed(this.error);
}
final class MakingPayment extends CheckoutState {}

final class PaymentMade extends CheckoutState {}

final class PaymentMakingFailed extends CheckoutState {
  final String error;

  PaymentMakingFailed(this.error);
}