import 'package:ecommerceapp/core/controllers/checkout/shipping_address/shipping_address_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../extensions/app_extentions.dart';
import '../../../models/shipping_address.dart';
import '../../../routes/routes.dart';
import '../../../theme/app_text_styles.dart';

class AddressHeader extends StatelessWidget {
  final ShippingAddressModel address;
  const AddressHeader({super.key, required this.address});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ShippingAddressCubit>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(address.fullName),
            Spacer(),
            InkWell(
              onTap: (){
                context.pushNamed(Routes.editAddress,arguments:{'cubit':cubit,'address':address});
              },
              child: Text(
                "Edit",
                style: AppTextStyles.font14PrimaryWeight500,
              ),
            ),
          ],
        ),
        Text(address.address).onlyPadding(bottomPadding: 10),
      ],
    ).onlyPadding(leftPadding: 28, rightPadding: 28, topPadding: 16);
  }
}
