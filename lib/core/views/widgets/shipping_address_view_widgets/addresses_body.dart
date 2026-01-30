import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../components/widgets/app_dialog.dart';
import '../../../controllers/checkout/shipping_address/shipping_address_cubit.dart';
import '../../../utils/app_messages.dart';
import '../addresses_view_widgets/address_card_shimmer.dart';
import 'address_card.dart';

class AddressesBody extends StatelessWidget {
  final ShippingAddressCubit shippingAddressCubit;
  const AddressesBody({super.key, required this.shippingAddressCubit});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShippingAddressCubit, ShippingAddressState>(
      bloc: shippingAddressCubit,
      buildWhen: (previous, current) =>
          current is ShippingAddressesLoading ||
          current is ShippingAddressesLoaded ||
          current is ShippingAddressAddingFailed,
      builder: (context, state) {
        if (state is ShippingAddressesLoading) {
          return ListView.builder(
            itemCount: state.shimmerCount,
            itemBuilder: (_, _) => const AddressCardShimmer(),
          );
        }
        if (state is ShippingAddressAddingFailed) {
          return AppDialog(message: state.error);
        }

        if (state is ShippingAddressesLoaded) {
          final List shippingAddresses = state.shippingAddresses;
          if (shippingAddresses.isEmpty) {
            return Center(child: Text(AppMessages.addAddressButton));
          }
          return ListView.builder(
            itemCount: shippingAddresses.length,
            itemBuilder: (context, index) {
              final address = shippingAddresses[index];
              return AddressCard(
                address: address,
                shippingAddressCubit: shippingAddressCubit,
              );
            },
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
