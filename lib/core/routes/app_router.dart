import 'package:ecommerceapp/core/controllers/home/home_cubit.dart';
import 'package:ecommerceapp/core/controllers/product_details/product_details_cubit.dart';
import 'package:ecommerceapp/core/models/product_model.dart';
import 'package:ecommerceapp/core/routes/routes.dart';
import 'package:ecommerceapp/core/utils/products_list_type.dart';
import 'package:ecommerceapp/core/views/Checkout_view.dart';
import 'package:ecommerceapp/core/views/category_details_view.dart';
import 'package:ecommerceapp/core/views/category_view.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../controllers/category/category_cubit.dart';
import '../controllers/navigation_controller.dart';
import '../views/forgot_password_view.dart';
import '../views/login_view.dart';
import '../views/main_view.dart';
import '../views/product_info_view.dart';
import '../views/signup_view.dart';

abstract class AppRouter {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.login:
        return CupertinoPageRoute(
          builder: (_) => LoginView(),
          settings: settings,
        );
      case Routes.checkout:
        return CupertinoPageRoute(
          builder: (_) => CheckoutView(),
          settings: settings,
        );
      case Routes.categoryProduct:
        final args = settings.arguments as Map<String, dynamic>;

        return CupertinoPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => CategoryCubit(args['products']),
            child: CategoryDetailsView(
              catName: args['catName'],
              gender: args['gender'],
              products: args['products'],
              catTypesList: args['catTypesList'],
            ),
          ),
        );

      case Routes.signup:
        return CupertinoPageRoute(
          builder: (_) => SignUpView(),
          settings: settings,
        );
      case Routes.productinfo:
        final productId = settings.arguments as String;
        return CupertinoPageRoute(
          builder: (_) => BlocProvider(
            create: (context) {
              final cubit = ProductDetailsCubit();
              cubit.getProductDetails(productId);
              return cubit;
            },
            child: ProductInfoView(),
          ),
          settings: settings,
        );
      case Routes.forgotPassword:
        return CupertinoPageRoute(
          builder: (_) => ForgotPasswordView(),
          settings: settings,
        );
      case Routes.homepage:
        return CupertinoPageRoute(
          builder: (_) => MultiProvider(
            providers: [
              ChangeNotifierProvider(
                create: (_) => NavigationController(),
              ),
              BlocProvider<HomeCubit>(
                create: (_) => HomeCubit()..getHomeProducts(),
              ),
            ],
            child: MainView(),
          ),
          settings: settings,
        );


      default:
        return CupertinoPageRoute(
          builder: (_) => const SignUpView(),
          settings: settings,
        );
    }
  }
}
