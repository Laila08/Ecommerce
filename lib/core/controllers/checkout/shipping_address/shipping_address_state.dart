part of 'shipping_address_cubit.dart';

@immutable
sealed class ShippingAddressState {}

final class ShippingAddressInitial extends ShippingAddressState {}

//------------------------------- ShippingAddresses -----------------------------
// getShippingAddresses
final class ShippingAddressesLoading extends ShippingAddressState {}

final class ShippingAddressesLoaded extends ShippingAddressState {
  final List<ShippingAddressModel> shippingAddresses;
  final ShippingAddressModel? defaultAddress;

  ShippingAddressesLoaded({
    required this.shippingAddresses,
    this.defaultAddress,
  });
}

final class ShippingAddressesFailed extends ShippingAddressState {
  final String error;

  ShippingAddressesFailed(this.error);
}

// setShippingAddresses
final class AddingShippingAddress extends ShippingAddressState {}

final class ShippingAddressAdded extends ShippingAddressState {}

final class ShippingAddressAddedSuccessfully extends ShippingAddressState {}

final class ShippingAddressAddingFailed extends ShippingAddressState {
  final String error;

  ShippingAddressAddingFailed(this.error);
}

final class MakingPreferred extends ShippingAddressState {}

final class PreferredMade extends ShippingAddressState {}

final class PreferredMakingFailed extends ShippingAddressState {
  final String error;

  PreferredMakingFailed(this.error);
}
