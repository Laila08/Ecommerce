import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../models/shipping_address.dart';
import '../../../services/auth_services.dart';
import '../../../services/checkout_services.dart';
import '../../../theme/app_text_styles.dart';

part 'shipping_address_state.dart';

class ShippingAddressCubit extends Cubit<ShippingAddressState> {
  ShippingAddressCubit() : super(ShippingAddressInitial());

  final checkoutServices = CheckoutServicesImpl();
  final authServices = AuthServicesImp();
  TextStyle countryTextStyle = AppTextStyles.font14GrayWeight500;
  void changeCountry(Country country) {
    countryController.text = country.name;
    countryTextStyle = AppTextStyles.font14BlackWeight400;
    emit(CountryTextStyleChanged());
  }
  final cityController = TextEditingController();
  final addressController = TextEditingController();
  final nameController = TextEditingController();
  final regionController = TextEditingController();
  final zipCodeController = TextEditingController();
  final countryController = TextEditingController();

  void clearControllers() {
    nameController.clear();
    addressController.clear();
    cityController.clear();
    regionController.clear();
    zipCodeController.clear();
    countryController.clear();
    countryTextStyle = AppTextStyles.font14GrayWeight500;
  }

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
    return null;
  }

  Future<void> getShippingAddresses() async {
    emit(ShippingAddressesLoading());
    try {
      final user = authServices.currentUser;
      final addresses = await checkoutServices.getShippingAddresses(user!.uid);
      final updatedAddresses = List<ShippingAddressModel>.from(addresses);
      bool existDefault = updatedAddresses.any((element) => element.isDefault);
      if (!existDefault && updatedAddresses.isNotEmpty) {
        updatedAddresses[0] = updatedAddresses[0].copyWith(isDefault: true);
      }
      final defaultList = updatedAddresses.where((e) => e.isDefault).toList();
      final ShippingAddressModel? defaultAddress = defaultList.isNotEmpty
          ? defaultList.first
          : null;
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
    try {
      await checkoutServices.saveShippingAddresses(
        user.uid,
        newShippingAddress,
      );
      await checkoutServices.setDefaultShippingAddress(
        user.uid,
        newShippingAddress.id,
      );
      final updatedAddresses = await checkoutServices.getShippingAddresses(
        user.uid,
      );
      ShippingAddressModel? defaultAddress;
      if (updatedAddresses.isNotEmpty) {
        defaultAddress = updatedAddresses.firstWhere(
          (e) => e.isDefault,
          orElse: () => updatedAddresses[0],
        );
      } else {
        defaultAddress = null;
      }
      emit(
        ShippingAddressesLoaded(
          shippingAddresses: updatedAddresses,
          defaultAddress: defaultAddress,
        ),
      );
      emit(ShippingAddressAddedSuccessfully());
    } catch (e) {
      emit(ShippingAddressAddingFailed(e.toString()));
    }
  }

  Future<void> makePreferred(ShippingAddressModel address) async {
    final user = authServices.currentUser;
    if (user == null) return;

    try {
      await checkoutServices.setDefaultShippingAddress(user.uid, address.id);

      final updatedAddresses = await checkoutServices.getShippingAddresses(
        user.uid,
      );
      ShippingAddressModel? defaultAddress;
      if (updatedAddresses.isNotEmpty) {
        defaultAddress = updatedAddresses.firstWhere(
          (e) => e.isDefault,
          orElse: () => updatedAddresses[0],
        );
      } else {
        defaultAddress = null;
      }

      emit(
        ShippingAddressesLoaded(
          shippingAddresses: updatedAddresses,
          defaultAddress: defaultAddress,
        ),
      );
    } catch (e) {
      emit(ShippingAddressAddingFailed(e.toString()));
    }
  }

  void fillControllersFromAddress(ShippingAddressModel address) {
    nameController.text = address.fullName;
    addressController.text = address.address;
    cityController.text = address.city;
    regionController.text = address.state;
    zipCodeController.text = address.zipCode;
    countryController.text = address.country;
  }

  Future<void> updateShippingAddress(ShippingAddressModel oldAddress) async {
    emit(EditingShippingAddress());

    final user = authServices.currentUser;
    if (user == null) return;

    try {
      final updatedAddress = oldAddress.copyWith(
        fullName: nameController.text.trim(),
        address: addressController.text.trim(),
        city: cityController.text.trim(),
        state: regionController.text.trim(),
        zipCode: zipCodeController.text.trim(),
        country: countryController.text.trim(),
      );
      await checkoutServices.saveShippingAddresses(user.uid, updatedAddress);
      final updatedAddresses = await checkoutServices.getShippingAddresses(
        user.uid,
      );
      final defaultAddress = updatedAddresses.firstWhere(
        (element) => element.isDefault,
        orElse: () => updatedAddresses.isNotEmpty
            ? updatedAddresses[0]
            : updatedAddresses.first,
      );
      emit(
        ShippingAddressesLoaded(
          shippingAddresses: updatedAddresses,
          defaultAddress: defaultAddress,
        ),
      );
      emit(ShippingAddressEdited());
    } catch (e) {
      emit(ShippingAddressEditingFailed(e.toString()));
    }
  }

  // Future<void> setShippingAddresses(
  //   ShippingAddressModel newShippingAddress,
  // ) async
  // {
  //   emit(AddingShippingAddress());
  //   final user = authServices.currentUser;
  //   if (user == null) return;
  //
  //   await checkoutServices.saveShippingAddresses(user.uid, newShippingAddress);
  //
  //   final updatedAddresses =
  //   await checkoutServices.getShippingAddresses(user.uid);
  //
  //   bool existDefault =
  //   updatedAddresses.any((element) => element.isDefault);
  //
  //   if (!existDefault && updatedAddresses.isNotEmpty) {
  //     updatedAddresses[0] =
  //         updatedAddresses[0].copyWith(isDefault: true);
  //   }
  //
  //   final defaultAddress =
  //   updatedAddresses.firstWhere(
  //         (e) => e.isDefault,
  //     orElse: () => updatedAddresses.first,
  //   );
  //
  //   emit(
  //     ShippingAddressesLoaded(
  //       shippingAddresses: updatedAddresses,
  //       defaultAddress: defaultAddress,
  //     ),
  //   );
  //
  //   emit(ShippingAddressAddedSuccessfully());
  // }

  // Future<void> makePreferred(ShippingAddressModel address) async {
  //   final user = authServices.currentUser;
  //   if (user == null) return;
  //   final currentState = state;
  //   if (currentState is ShippingAddressesLoaded) {
  //     final addresses = List<ShippingAddressModel>.from(
  //       currentState.shippingAddresses,
  //     );
  //     final updateDefaults = addresses
  //         .map(
  //           (e) => e.id == address.id
  //               ? e.copyWith(isDefault: true)
  //               : e.copyWith(isDefault: false),
  //         )
  //         .toList();
  //     final defaultList = updateDefaults.where((e) => e.isDefault).toList();
  //     final ShippingAddressModel? defaultAddress =
  //     defaultList.isNotEmpty ? defaultList.first : null;
  //
  //     emit(
  //       ShippingAddressesLoaded(
  //         shippingAddresses: updateDefaults,
  //         defaultAddress: defaultAddress,
  //       ),
  //     );
  //   }
  // }
}
