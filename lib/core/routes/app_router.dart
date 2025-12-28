import 'package:ecommerceapp/core/routes/routes.dart';
import 'package:ecommerceapp/features/auth/presentation/views/forgot_password_view.dart';
import 'package:ecommerceapp/features/auth/presentation/views/login_view.dart';
import 'package:ecommerceapp/features/auth/presentation/views/product_info_view.dart';
import 'package:ecommerceapp/features/auth/presentation/views/signup_view.dart';
import 'package:ecommerceapp/features/splash/presentation/views/splash_view.dart';
import 'package:ecommerceapp/features/splash/presentation/views/widgets/home_page.dart';
import 'package:ecommerceapp/product_model.dart';
import 'package:flutter/cupertino.dart';

abstract class AppRouter {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.login:
        return CupertinoPageRoute(
          builder: (_) => LoginView(),
          settings: settings,
        );
      case Routes.signup:
        return CupertinoPageRoute(
          builder: (_) => SignUpView(),
          settings: settings,
        );
      case Routes.productinfo:
        return CupertinoPageRoute(
          builder: (_) =>
              ProductInfoView(product: settings.arguments as ProductModel),
          settings: settings,
        );
      case Routes.forgotPassword:
        return CupertinoPageRoute(
          builder: (_) => ForgotPasswordView(),
          settings: settings,
        );
      case Routes.homepage:
        return CupertinoPageRoute(
          builder: (_) => const HomePage(),
          settings: settings,
        );
      case Routes.splash:
        return CupertinoPageRoute(
          builder: (_) => const SplashView(),
          settings: settings,
        );
      default:
        return CupertinoPageRoute(
          builder: (_) => const SplashView(),
          settings: settings,
        );
    }
  }
}
