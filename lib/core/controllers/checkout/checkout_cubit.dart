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



}
