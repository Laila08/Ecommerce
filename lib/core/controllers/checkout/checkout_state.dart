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

  DeliveryMethodLoaded({
    required this.deliveryMethods,
    this.shippingAddress,
    this.selectedMethod,
  });
}

final class DeliveryMethodFailed extends CheckoutState {
  final String error;

  DeliveryMethodFailed(this.error);
}