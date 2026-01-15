import 'package:bloc/bloc.dart';
import 'package:ecommerceapp/core/services/auth_services.dart';
import 'package:meta/meta.dart';

import '../../models/delivery_method_model.dart';
import '../../models/shipping_address.dart';
import '../../services/checkout_services.dart';

part 'checkout_state.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  CheckoutCubit() : super(CheckoutInitial());
  final checkoutServices = CheckoutServicesImpl();
  final authServices = AuthServicesImp();
  Future<void> getDeliveryMethods() async {
    final deliveryMethods = await checkoutServices.getDeliveryMethods();
    emit(
      CheckoutLoaded(
        deliveryMethods: deliveryMethods,
        selectedMethod: deliveryMethods.first,
      ),
    );
  }

  void setSelectedMethode(DeliveryMethodModel deliveryMethod) {
    if (state is CheckoutLoaded) {
      final current = state as CheckoutLoaded;
      emit(
        CheckoutLoaded(
          deliveryMethods: current.deliveryMethods,
          selectedMethod: deliveryMethod,
          shippingAddress: current.shippingAddress,
        ),
      );
    }
  }

}
