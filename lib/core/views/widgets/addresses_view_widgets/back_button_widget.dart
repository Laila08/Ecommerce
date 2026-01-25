import 'package:flutter/material.dart';

import '../../../controllers/checkout/shipping_address/shipping_address_cubit.dart';
import '../../../extensions/app_extentions.dart';

class BackButtonWidget extends StatelessWidget {
  final ShippingAddressCubit shippingAddressCubit;
  const BackButtonWidget({super.key, required this.shippingAddressCubit});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        final state = shippingAddressCubit.state;
        if (state is ShippingAddressesLoaded &&
            state.shippingAddresses.isNotEmpty) {
          context.pop();
        } else {
          Navigator.pop(context);
         // context.pop();
        }
      },
      icon: Icon(Icons.arrow_back_ios),
    );
  }
}
