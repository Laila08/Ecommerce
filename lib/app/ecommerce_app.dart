import 'package:ecommerceapp/core/controllers/auth_controller.dart';
import 'package:ecommerceapp/core/controllers/navigation_controller.dart';
import 'package:ecommerceapp/core/services/auth_services.dart';
import 'package:ecommerceapp/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/routes/app_router.dart';

class EcommerceApp extends StatelessWidget {
  const EcommerceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthServices>(
            create:(_) => Auth(),),
        ChangeNotifierProvider(
          create: (_) => NavigationController(),
        ),
        ChangeNotifierProvider(
          create: (context) => AuthController(auth:context.read<AuthServices>() ),
             )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: AppColors.primaryColor,
          fontFamily: "Metropolis",
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        onGenerateRoute: AppRouter.generateRoute,
      ),
    );
  }
}
