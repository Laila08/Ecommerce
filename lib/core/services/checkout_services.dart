import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/delivery_method_model.dart';
import '../models/shipping_address.dart';
import '../utils/api_path.dart';
import 'firestore_services.dart';

abstract class CheckoutServices {
  Future<List<ShippingAddressModel>> getShippingAddresses(String uid);
  Future<List<DeliveryMethodModel>> getDeliveryMethods();
  Future<void> saveAddress(String userId, ShippingAddressModel shippingAddress);
}

class CheckoutServicesImpl implements CheckoutServices {
  final _services = FirestoreServices.instance;

  @override
  Future<List<DeliveryMethodModel>> getDeliveryMethods() async =>
      await _services.getCollection(
        path: ApiPath.deliveryMethods(),
        builder: (data, documentId) =>
            DeliveryMethodModel.fromMap(data, documentId),
      );

  @override
  Future<List<ShippingAddressModel>> getShippingAddresses(String userId) async =>
      await _services.getCollection(
        path: ApiPath.userShippingAddress(userId),
        builder: (data, documentId) =>
            ShippingAddressModel.fromMap(data, documentId),
      );

  @override
  Future<void> saveAddress(
    String userId,
    ShippingAddressModel shippingAddress,
  ) async => await _services.setData(
    path: ApiPath.newShippingAddress(userId, shippingAddress.id),
    data: shippingAddress.toMap(),
  );
}
