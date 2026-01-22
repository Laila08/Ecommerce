import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../controllers/checkout/shipping_address/shipping_address_cubit.dart';
import 'widgets/shipping_address_view_widgets/Addresses_FAB.dart';
import 'widgets/shipping_address_view_widgets/addresses_appBar.dart';
import 'widgets/shipping_address_view_widgets/addresses_body.dart';

class AddressesView extends StatefulWidget {
  final double totalPrice;
  const AddressesView({super.key, required this.totalPrice});
  @override
  State<AddressesView> createState() => _AddressesViewState();
}

class _AddressesViewState extends State<AddressesView> {
  late ShippingAddressCubit shippingAddressCubit;
  @override
  void initState() {
    super.initState();
    shippingAddressCubit = context.read<ShippingAddressCubit>();
    shippingAddressCubit.getShippingAddresses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AddressesAppBar(
        totalPrice: widget.totalPrice,
        shippingAddressCubit: shippingAddressCubit,
      ),
      body: AddressesBody(shippingAddressCubit: shippingAddressCubit),
      floatingActionButton: AddressesFAB(
        shippingAddressCubit: shippingAddressCubit,
      ),
    );
  }
}

