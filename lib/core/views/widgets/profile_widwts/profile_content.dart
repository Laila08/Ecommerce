
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../controllers/auth/auth_cubit.dart';
import '../../../extensions/app_extentions.dart';
import '../../../routes/routes.dart';
import 'profile_header.dart';
import 'profile_menu_item.dart';

class ProfileContent extends StatelessWidget {
  const ProfileContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ProfileHeader(
          name: "Matilda Brown",
          email: "matildabrown@mail.com",
        ).onlyPadding(bottomPadding: 20, leftPadding: 15),

        ProfileMenuItem(
          title: "My orders",
          subtitle: "Already have 12 orders",
        ),
        ProfileMenuItem(
          title: "Shipping addresses",
          subtitle: "3 addresses",
        ),
        ProfileMenuItem(
          title: "Payment methods",
          subtitle: "Visa  **34",
        ),
        ProfileMenuItem(
          title: "Promo codes",
          subtitle: "You have special promo codes",
        ),
        ProfileMenuItem(
          title: "My reviews",
          subtitle: "Reviews for 4 items",
        ),
        ProfileMenuItem(
          title: "Settings",
          subtitle: "Notifications, password",
        ),
        ElevatedButton(
          onPressed: () {
            BlocProvider.of<AuthCubit>(context).logout();
            context.pushReplacementNamed(Routes.signup);
          },
          child: Text("Logout"),
        )
      ],
    );
  }
}
