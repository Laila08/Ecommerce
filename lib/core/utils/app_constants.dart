class AppConstants {
  AppConstants._();

  static const List<String> categoryTabs = ['Women', 'Men', 'Kids'];
  static const double kCupertinoNavigationBarHeight = 44.0;
  static const List<String> sortOptions = [
    'Popular',
    'Newest',
    'Customer review',
    'Price: lowest to high',
    'Price: highest to low',
  ];

  static const String paymentIntentPath = 'https://api.stripe.com/v1/payment_intents';
  static const String secretKey = 'REDACTED';
  static const String publishableKey = 'pk_test_51SNEXcED9VjxD42VU83XQVzIiU8L2cSWbC5M0LVNsad4mmjAsDf24YyzEAcmh9eV4hrGVNzA8lpHwC6TlXGGJkLr00dJCVq9ZP';

}
