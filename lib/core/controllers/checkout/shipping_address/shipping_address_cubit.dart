import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:postcode_checker/postcode_checker.dart';

import '../../../models/shipping_address.dart';
import '../../../services/auth_services.dart';
import '../../../services/checkout_services.dart';
import '../../../theme/app_text_styles.dart';
import 'package:meta/meta.dart';

part 'shipping_address_state.dart';

class ShippingAddressCubit extends Cubit<ShippingAddressState> {
  ShippingAddressCubit() : super(ShippingAddressInitial());

  final checkoutServices = CheckoutServicesImpl();
  final authServices = AuthServicesImp();
  TextStyle countryTextStyle = AppTextStyles.font14GrayWeight500;
  Country? selectedCountry;

  final cityController = TextEditingController();
  final addressController = TextEditingController();
  final nameController = TextEditingController();
  final regionController = TextEditingController();
  final zipCodeController = TextEditingController();
  final countryController = TextEditingController();

  void changeCountry(Country country) {
    selectedCountry = country;
    countryController.text = country.name;
    countryTextStyle = AppTextStyles.font14BlackWeight400;
    emit(CountryTextStyleChanged());
  }

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

    if (zipCode.isEmpty) return "ZIP/Postal Code is required";
    if (selectedCountry == null) return "Please select a country first";

    if (selectedCountry!.countryCode.toUpperCase() == 'PS') {
      if (!RegExp(r'^[A-Za-z0-9 ]{3,10}$').hasMatch(zipCode)) {
        return "Invalid ZIP/Postal Code";
      }
      return null;
    }
    late CountryCode countryEnum;
    try {
      countryEnum = CountryCode.values.firstWhere(
        (c) =>
            c.name.toUpperCase() == selectedCountry!.countryCode.toUpperCase(),
      );
    } catch (e) {
      return "Unsupported country for ZIP code validation";
    }

    final result = PostcodeChecker.validate(countryEnum, zipCode);
    if (!result.isValid)
      return "Invalid ZIP/Postal Code for ${selectedCountry!.name}";

    return null;
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
    final previousCount = state is ShippingAddressesLoaded
        ? (state as ShippingAddressesLoaded).shippingAddresses.length
        : 3;

    emit(ShippingAddressesLoading(shimmerCount: previousCount));

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
    final currentState = state;
    emit(MakingPreferred(address.id));
    if (currentState is ShippingAddressesLoaded) {
      final updatedList = currentState.shippingAddresses.map((a) {
        if (a.id == address.id) {
          return a.copyWith(isDefault: true);
        } else {
          return a.copyWith(isDefault: false);
        }
      }).toList();

      emit(
        ShippingAddressesLoaded(
          shippingAddresses: updatedList,
          defaultAddress: address,
        ),
      );
    }
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
      emit(PreferredMade());
    } catch (e) {
      emit(PreferredMakingFailed(e.toString()));
    }
  }

  void fillControllersFromAddress(ShippingAddressModel address) {
    nameController.text = address.fullName;
    addressController.text = address.address;
    cityController.text = address.city;
    regionController.text = address.state;
    zipCodeController.text = address.zipCode;
    countryController.text = address.country;
    try {
      selectedCountry = Country.tryParse(address.country);
    } catch (_) {
      selectedCountry = null;
    }
    if (selectedCountry != null) {
      countryTextStyle = AppTextStyles.font14BlackWeight400;
      emit(CountryTextStyleChanged());
    }
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
        country: selectedCountry?.name ?? countryController.text.trim(),
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
}
