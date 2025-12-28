import 'package:ecommerceapp/core/controllers/firestore_controller.dart';
import 'package:ecommerceapp/core/services/auth_services.dart';
import 'package:ecommerceapp/features/auth/presentation/views/main_view.dart';
import 'package:ecommerceapp/features/auth/presentation/views/signup_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthServices>(context,listen: false);
    return StreamBuilder(
        stream: auth.authStateChanges(),
        builder: (context, asyncSnapshot) {
          if(asyncSnapshot.connectionState == ConnectionState.active){
            final user = asyncSnapshot.data;
            if(user == null){
              return SignUpView();
            }
            return Provider<DataBase>(
              create: (context) => FireStoreDatabase(user.uid),
                child: MainView());
          }
          return const Scaffold(
            body: CircularProgressIndicator(),
          );
        },
      );
  }
}
