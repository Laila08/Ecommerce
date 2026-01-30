import 'package:ecommerceapp/core/controllers/checkout/shipping_address/shipping_address_cubit.dart';
import 'package:ecommerceapp/core/controllers/product_details/product_details_cubit.dart';
import 'package:ecommerceapp/core/extensions/app_extentions.dart';
import 'package:ecommerceapp/core/models/shipping_address.dart';
import 'package:ecommerceapp/core/theme/app_text_styles.dart';
import 'package:ecommerceapp/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../components/widgets/loading_button_widget.dart';
import '../utils/app_messages.dart';
import '../utils/constants.dart';
import 'widgets/addresses_view_widgets/address_field.dart';
import 'widgets/addresses_view_widgets/back_button_widget.dart';
import 'widgets/addresses_view_widgets/city_field.dart';
import 'widgets/addresses_view_widgets/country_field.dart';
import 'widgets/addresses_view_widgets/full_name_field.dart';
import 'widgets/addresses_view_widgets/region_field.dart';
import 'widgets/addresses_view_widgets/save_button.dart';
import 'widgets/addresses_view_widgets/zip_code_field.dart';

class AddingAddressesView extends StatelessWidget {
  const AddingAddressesView({super.key});

  @override
  Widget build(BuildContext context) {
    final shippingAddressCubit = context.read<ShippingAddressCubit>();
    final formKey = GlobalKey<FormState>();

    Future<void> saveAddress(ShippingAddressCubit shippingAddressCubit) async {
      if (formKey.currentState!.validate()) {
        final address = ShippingAddressModel(
          id: documentidFromLocalData(),
          fullName: shippingAddressCubit.nameController.text,
          country: shippingAddressCubit.countryController.text,
          address: shippingAddressCubit.addressController.text,
          city: shippingAddressCubit.cityController.text,
          state: shippingAddressCubit.regionController.text,
          zipCode: shippingAddressCubit.zipCodeController.text,
          isDefault: true,
        );
        await shippingAddressCubit.setShippingAddresses(address);
        shippingAddressCubit.clearControllers();
      }
    }

    return BlocListener<ShippingAddressCubit, ShippingAddressState>(
      listener: (context, state) {
        if (state is ShippingAddressAddedSuccessfully) {
          Navigator.pop(context, true);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.whiteColor,
          leading: BackButtonWidget(shippingAddressCubit: shippingAddressCubit),
          title: Text(
            AppMessages.addingShippingAddress,
            style: AppTextStyles.font18BlackWeight400,
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              spacing: 20,
              children: [
                FullNameField(cubit: shippingAddressCubit),
                AddressField(cubit: shippingAddressCubit),
                CityField(cubit: shippingAddressCubit),
                RegionField(cubit: shippingAddressCubit),
                ZipCodeField(cubit: shippingAddressCubit),
                CountryField(cubit: shippingAddressCubit),
                BlocConsumer<ShippingAddressCubit, ShippingAddressState>(
                  bloc: shippingAddressCubit,
                  buildWhen: (previous, current) =>
                  current is  AddingShippingAddress ||
                  current is ShippingAddressAdded,
                  listenWhen: (previous, current) =>
                      current is AddingShippingAddress ||
                      current is ShippingAddressAddingFailed,
                  listener: (context, state) {
                    if (state is ShippingAddressAddingFailed) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            AppMessages.shippingAddressAddingFailed,
                          ),
                          backgroundColor: AppColors.primaryColor,
                        ),
                      );
                    }
                    if (state is ShippingAddressAdded) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(AppMessages.addressAddedSuccessfully),
                          backgroundColor: AppColors.primaryColor,
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is AddingShippingAddress) {
                      return LoadingButtonWidget();
                    }
                    return SaveButton(
                      title: AppMessages.saveAddressButton,
                      onTap: () => saveAddress(shippingAddressCubit),
                    );
                  },
                ),
              ],
            ).horizontalPadding(17).verticalPadding(40),
          ),
        ),
      ),
    );
  }
}
