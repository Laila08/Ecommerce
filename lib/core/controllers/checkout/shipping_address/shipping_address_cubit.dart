import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../models/shipping_address.dart';
import '../../../services/auth_services.dart';
import '../../../services/checkout_services.dart';

part 'shipping_address_state.dart';

class ShippingAddressCubit extends Cubit<ShippingAddressState> {
  ShippingAddressCubit() : super(ShippingAddressInitial());

  final checkoutServices = CheckoutServicesImpl();
  final authServices = AuthServicesImp();

  final cityController = TextEditingController();
  final addressController = TextEditingController();
  final nameController = TextEditingController();
  final regionController = TextEditingController();
  final zipCodeController = TextEditingController();
  final countryController = TextEditingController();

  String? validateName() {
    final name = nameController.text.trim();

    if (name.isEmpty) {
      return "Name is required";
    }
    if (name.length < 2 || name.length > 40) {
      return "Name should contain 2–40 characters";
    }
    return null;
  }

  String? validateCity() {
    final city = cityController.text.trim();

    if (city.isEmpty) {
      return "City is required";
    }
    if (city.length < 2 || city.length > 60) {
      return "City name should contain 2–60 characters";
    }
    return null;
  }

  String? validateAddress() {
    final address = addressController.text.trim();

    if (address.isEmpty) {
      return "Address is required";
    }
    if (address.length < 5 || address.length > 100) {
      return "Address should contain 5–100 characters";
    }
    return null;
  }

  String? validateZipCode() {
    final zipCode = zipCodeController.text.trim();

    if (zipCode.isEmpty) {
      return "ZIP/Postal Code is required";
    }

    if (zipCode.length < 3) {
      return "Invalid ZIP/Postal Code";
    }

    if ((zipCode.startsWith('P') || zipCode.startsWith('p')) &&
        (zipCode.length == 3 || zipCode.length == 7)) {
      return null;
    }

    return "ZIP/Postal Code should be 3 or 7 characters starting with P";
  }

  String? validateRegion() {
    final region = regionController.text.trim();

    if (region.isEmpty) {
      return "Region is required";
    }
    if (region.length < 5 || region.length > 100) {
      return "Region name should contain 5–100 characters";
    }
    return null;
  }

  String? validateCountry() {
    final country = countryController.text.trim();

    if (country.isEmpty) {
      return "Country is required";
    }
    if (country.length < 2) {
      return "Country name is too short";
    }
    return null;
  }


  Future<void> getShippingAddresses() async {
    emit(ShippingAddressesLoading());
    try {
      final user = authServices.currentUser;
      final addresses = await checkoutServices.getShippingAddresses(user!.uid);
      final updatedAddresses = List<ShippingAddressModel>.from(addresses);
      bool existDefault = updatedAddresses.any((element) => element.isDefault);
      if (!existDefault&& updatedAddresses.isNotEmpty) {
        updatedAddresses[0] = updatedAddresses[0].copyWith(isDefault: true);
      }
      final defaultList = updatedAddresses.where((e) => e.isDefault).toList();
      final ShippingAddressModel? defaultAddress =
      defaultList.isNotEmpty ? defaultList.first : null;
      emit(
        ShippingAddressesLoaded(
          shippingAddresses: updatedAddresses,
          defaultAddress: defaultAddress,
        ),
      );
    } catch (e) {
      emit(ShippingAddressesFailed(e.toString()));
    }
  }

  Future<void> setShippingAddresses(
    ShippingAddressModel newShippingAddress,
  ) async {
    emit(AddingShippingAddress());
    final user = authServices.currentUser;
    if (user == null) return;

    await checkoutServices.saveShippingAddresses(user.uid, newShippingAddress);

    final updatedAddresses = await checkoutServices.getShippingAddresses(
      user.uid,
    );
    emit(ShippingAddressesLoaded(shippingAddresses: updatedAddresses));
    emit(ShippingAddressAddedSuccessfully());
  }

  Future<void> makePreferred(ShippingAddressModel address) async {
    final user = authServices.currentUser;
    if (user == null) return;
    final currentState = state;
    if (currentState is ShippingAddressesLoaded) {
      final addresses = List<ShippingAddressModel>.from(
        currentState.shippingAddresses,
      );
      final updateDefaults = addresses
          .map(
            (e) => e.id == address.id
                ? e.copyWith(isDefault: true)
                : e.copyWith(isDefault: false),
          )
          .toList();
      final defaultList = updateDefaults.where((e) => e.isDefault).toList();
      final ShippingAddressModel? defaultAddress =
      defaultList.isNotEmpty ? defaultList.first : null;

      emit(
        ShippingAddressesLoaded(
          shippingAddresses: updateDefaults,
          defaultAddress: defaultAddress,
        ),
      );
    }
  }
}
