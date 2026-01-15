import 'package:flutter/material.dart';

import '../../../components/widgets/main_button.dart';
import '../../../extensions/app_extentions.dart';
import '../../../routes/routes.dart';

class CartCheckoutButton extends StatelessWidget {
  final double totalPrice;
  const CartCheckoutButton({super.key, required this.totalPrice});

  @override
  Widget build(BuildContext context) {
    return MainButton(
      title: "CHECK OUT",
      onTap: () => context.pushNamed(Routes.checkout,arguments: totalPrice),
    ).onlyPadding(bottomPadding: 20);
  }
}
