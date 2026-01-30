import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerceapp/core/controllers/checkout/shipping_address/shipping_address_cubit.dart';
import 'package:ecommerceapp/core/models/shipping_address.dart';
import 'package:ecommerceapp/core/theme/app_text_styles.dart';
import 'package:ecommerceapp/core/utils/app_colors.dart';
import 'package:ecommerceapp/core/extensions/app_extentions.dart';
import '../components/widgets/loading_button_widget.dart';
import '../utils/app_messages.dart'; // استدعاء AppMessages

import 'widgets/addresses_view_widgets/full_name_field.dart';
import 'widgets/addresses_view_widgets/address_field.dart';
import 'widgets/addresses_view_widgets/city_field.dart';
import 'widgets/addresses_view_widgets/region_field.dart';
import 'widgets/addresses_view_widgets/zip_code_field.dart';
import 'widgets/addresses_view_widgets/country_field.dart';
import 'widgets/addresses_view_widgets/save_button.dart';

class EditingAddressView extends StatefulWidget {
  final ShippingAddressModel address;
  const EditingAddressView({super.key, required this.address});

  @override
  State<EditingAddressView> createState() => _EditingAddressViewState();
}

class _EditingAddressViewState extends State<EditingAddressView> {
  late final ShippingAddressCubit shippingAddressCubit;
  late final GlobalKey<FormState> formKey;

  @override
  void initState() {
    super.initState();
    shippingAddressCubit = context.read<ShippingAddressCubit>();
    shippingAddressCubit.fillControllersFromAddress(widget.address);
    formKey = GlobalKey<FormState>();
  }

  Future<void> updateAddress() async {
    if (formKey.currentState?.validate() ?? false) {
      await shippingAddressCubit.updateShippingAddress(widget.address);
      shippingAddressCubit.clearControllers();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        leading: IconButton(
          onPressed: () {
            context.pop();
            shippingAddressCubit.clearControllers();
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: const Text(
          AppMessages.editingAddressTitle,
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
                listenWhen: (previous, current) =>
                    current is ShippingAddressEdited ||
                    current is ShippingAddressEditingFailed,
                listener: (context, state) {
                  if (state is ShippingAddressEditingFailed) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(AppMessages.shippingAddressEditingFailed),
                        backgroundColor: AppColors.primaryColor,
                      ),
                    );
                  }
                  if (state is ShippingAddressEdited) {
                    Navigator.pop(context,true);
                  }
                },
                buildWhen: (previous, current)  =>
                current is EditingShippingAddress ||
                    current is ShippingAddressEdited,
                builder: (context, state) {
                  if (state is EditingShippingAddress) {
                    return LoadingButtonWidget();
                  }
                  return SaveButton(
                    title: AppMessages.editAddressButton,
                    onTap: () {
                       updateAddress();
                    },
                  );
                },
              ),
            ],
          ).horizontalPadding(17).verticalPadding(40),
        ),
      ),
    );
  }
}
