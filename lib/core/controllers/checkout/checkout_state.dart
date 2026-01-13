part of 'checkout_cubit.dart';

@immutable
sealed class CheckoutState {}

final class CheckoutInitial extends CheckoutState {}

final class CheckoutLoading extends CheckoutState {}

final class CheckoutLoaded extends CheckoutState {
  final List<DeliveryMethodModel> deliveryMethods;
  final ShippingAddressModel? shippingAddress;

  CheckoutLoaded({
    required this.deliveryMethods,
    this.shippingAddress,

  });
}

final class CheckoutFailed extends CheckoutState {
  final String error;

  CheckoutFailed(this.error);
}

final class FetchingAddresses extends CheckoutState {}

final class AddressesFetched extends CheckoutState {
  final List<ShippingAddressModel> shippingAddresses;

  AddressesFetched(this.shippingAddresses);
}

final class AddressesFetchingFailed extends CheckoutState {
  final String error;

  AddressesFetchingFailed(this.error);
}

final class AddingAddress extends CheckoutState {}

final class AddressAdded extends CheckoutState {}

final class AddressAddingFailed extends CheckoutState {
  final String error;

  AddressAddingFailed(this.error);
}

final class MakingPreferred extends CheckoutState {}

final class PreferredMade extends CheckoutState {}

final class PreferredMakingFailed extends CheckoutState {
  final String error;

  PreferredMakingFailed(this.error);
}
