import 'package:ecommerceapp/core/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../models/delivery_method_model.dart';
import '../../models/shipping_address.dart';
import '../../services/checkout_services.dart';
import '../../services/strip_services.dart';

part 'checkout_state.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  CheckoutCubit() : super(DeliveryMethodInitial());
  final checkoutServices = CheckoutServicesImpl();
  final authServices = AuthServicesImp();
  final stripeServices = StripeServices.instance;
  Future<void> makePayment(double amount) async {
    if (!isClosed) emit(MakingPayment());
    try {
      final double stripeAmount = (amount * 100);
      await stripeServices.makePayment(stripeAmount, 'usd');
      if (!isClosed) emit(PaymentMade());
    } catch (e) {
      debugPrint(e.toString());
      if (!isClosed) emit(PaymentMakingFailed(e.toString()));
    }
  }

  Future<void> getDeliveryMethods(double orderPrice) async {
    emit(DeliveryMethodLoading());
    final deliveryMethods = await checkoutServices.getDeliveryMethods();
    final selected = deliveryMethods.first;

    emit(
      DeliveryMethodLoaded(
        deliveryMethods: deliveryMethods,
        selectedMethod: deliveryMethods.first,
        orderPrice: orderPrice,
        totalAmount: orderPrice + selected.price,
      ),
    );
  }

  void setSelectedMethode(DeliveryMethodModel deliveryMethod) {
    if (state is DeliveryMethodLoaded) {
      final current = state as DeliveryMethodLoaded;
      emit(
        DeliveryMethodLoaded(
          deliveryMethods: current.deliveryMethods,
          selectedMethod: deliveryMethod,
          shippingAddress: current.shippingAddress,
          orderPrice: current.orderPrice,
          totalAmount: current.orderPrice + deliveryMethod.price,
        ),
      );
    }
  }
}
