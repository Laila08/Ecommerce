import 'package:ecommerceapp/core/extensions/app_extentions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../components/widgets/loading_button_widget.dart';
import '../../../components/widgets/main_button.dart';
import '../../../controllers/checkout/checkout_cubit.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_messages.dart';

class SubmitOrderButton extends StatelessWidget {
  final double amount;
  final CheckoutCubit checkoutCubit;

  const SubmitOrderButton({
    super.key,
    required this.amount,
    required this.checkoutCubit,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CheckoutCubit, CheckoutState>(
      bloc:  checkoutCubit,
      buildWhen: (previous, current) =>
          current is PaymentMade ||
          current is PaymentMakingFailed ||
          current is MakingPayment,
      listener: (BuildContext context, CheckoutState state) {
        if(state is PaymentMakingFailed){
          print("//////////////////////////////");
          print(state.error.toString());
          if (!context.mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
             SnackBar(
              content: Text(state.error),
              backgroundColor: AppColors.errorColor,
            ),
          );
        }
      },
      listenWhen: (previous, current) =>  current is PaymentMakingFailed,
      builder: (context, state) {
        if (state is MakingPayment) {
          return MainButton(
            child: LoadingButtonWidget(),
          );
        }
        return MainButton(
          title: AppMessages.submitOrder.toUpperCase(),
          onTap: () async => await checkoutCubit.makePayment(amount),
        );
      },
    ).onlyPadding(topPadding: 30);
  }
}
