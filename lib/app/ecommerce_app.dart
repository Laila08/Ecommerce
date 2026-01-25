import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/controllers/auth/auth_cubit.dart';
import '../core/controllers/cart/cart_cubit.dart';
import '../core/controllers/checkout/shipping_address/shipping_address_cubit.dart';
import '../core/controllers/favorite/favorite_cubit.dart';
import '../core/controllers/home/home_cubit.dart';
import '../core/controllers/navigation/navigation_cubit.dart';
import '../core/controllers/view_mode/view_mode_cubit.dart';
import '../core/routes/app_router.dart';
import '../core/routes/routes.dart';
import '../core/utils/app_colors.dart';

class EcommerceApp extends StatelessWidget {
  const EcommerceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
          AuthCubit()
            ..authStatus(),
        ),
        BlocProvider(
          create: (_) => HomeCubit()..getHomeProducts(),
        ),
        BlocProvider(create: (_) => CartCubit()),

        BlocProvider(
          create: (context) => FavoriteCubit()..getFavorites(),
        ),
        BlocProvider(create: (_) => ShippingAddressCubit()..getShippingAddresses()),
        BlocProvider(create: (context) => ViewModeCubit()),

      ],
      child: Builder(
          builder: (context) {
            return BlocBuilder<AuthCubit, AuthState>(
              bloc: BlocProvider.of<AuthCubit>(context),
              buildWhen: (previous, current) =>
              current is AuthSuccess ||
                  current is AuthLoading ||
                  current is AuthFailed ||
                  current is AuthInitial,
              builder: (context, state) {
                return MaterialApp(
                  title: 'Flutter Demo',
                  debugShowCheckedModeBanner: false,
                  theme: ThemeData(
                    primaryColor: AppColors.primaryColor,
                    fontFamily: "Metropolis",
                    scaffoldBackgroundColor: AppColors.backGroundColor,
                    colorScheme: ColorScheme.fromSeed(
                      seedColor: Colors.deepPurple,
                    ),
                  ),
                  onGenerateRoute: AppRouter.generateRoute,
                  initialRoute: state is AuthSuccess ? Routes.homepage : Routes.signup,
                );
              },
            );
          }
      ),
    );
  }
}
