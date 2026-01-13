import 'package:ecommerceapp/core/controllers/favorite/favorite_cubit.dart';
import 'package:ecommerceapp/core/routes/routes.dart';
import 'package:ecommerceapp/core/utils/app_colors.dart';
import 'package:ecommerceapp/core/controllers/auth/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/routes/app_router.dart';

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
          create: (context) => FavoriteCubit()..getFavorites(),
        ),
      ],
      child: Builder(
          builder: (context) {
            return BlocBuilder<AuthCubit, AuthState>(
              bloc: BlocProvider.of<AuthCubit>(context),
              buildWhen: (previous, current) =>
              current is AuthSuccess ||
                  current is AuthLoading ||
                  ////////////////////////////////////////////////////////////////////// AuthFailed ما ضافها
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
                  initialRoute: state is AuthSuccess ? Routes.homepage : Routes
                      .signup,
                );
              },
            );
          }
      ),
    );
  }
}
