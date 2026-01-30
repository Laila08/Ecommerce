import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import 'app/ecommerce_app.dart';
import 'core/utils/app_constants.dart';

void main()async {
  await initSetup();
    runApp(const EcommerceApp());
}
Future<void> initSetup() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Stripe.publishableKey = AppConstants.publishableKey;
}