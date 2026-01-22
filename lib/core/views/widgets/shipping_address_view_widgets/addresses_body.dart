import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../components/widgets/app_dialog.dart';
import '../../../controllers/checkout/shipping_address/shipping_address_cubit.dart';
import '../../../extensions/app_extentions.dart';
import 'address_card.dart';

class AddressesBody extends StatelessWidget {
  final ShippingAddressCubit shippingAddressCubit;
  const AddressesBody({super.key, required this.shippingAddressCubit});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShippingAddressCubit, ShippingAddressState>(
      bloc: shippingAddressCubit,
      buildWhen: (previous, current) =>
      current is AddingShippingAddress ||
          current is ShippingAddressesLoaded ||
          current is ShippingAddressAddingFailed,
      builder: (context, state) {
        if (state is AddingShippingAddress) return CircularProgressIndicator().center();
        if (state is ShippingAddressAddingFailed) return AppDialog(message: state.error);
        if (state is ShippingAddressesLoaded) {
          final shippingAddresses = state.shippingAddresses;
          return ListView.builder(
            itemCount: shippingAddresses.length,
            itemBuilder: (context, index) {
              final address = shippingAddresses[index];
              return AddressCard(address: address, shippingAddressCubit: shippingAddressCubit);
            },
          );
        }
        return SizedBox.shrink();
      },
    );
  }
}
