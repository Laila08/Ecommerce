import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../controllers/auth/auth_cubit.dart';
import '../../../extensions/app_extentions.dart';
import '../../../routes/routes.dart';
import '../../../utils/app_messages.dart';
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

        const ProfileMenuItem(
          title: "My orders",
          subtitle: "Already have 12 orders",
        ),
        const ProfileMenuItem(
          title: "Shipping addresses",
          subtitle: "3 addresses",
        ),
        const ProfileMenuItem(
          title: "Payment methods",
          subtitle: "Visa  **34",
        ),
        const ProfileMenuItem(
          title: "Promo codes",
          subtitle: "You have special promo codes",
        ),
        const ProfileMenuItem(
          title: "My reviews",
          subtitle: "Reviews for 4 items",
        ),
        const ProfileMenuItem(
          title: "Settings",
          subtitle: "Notifications, password",
        ),
        ElevatedButton(
          onPressed: () {
            context.read<AuthCubit>().logout();
            context.pushReplacementNamed(Routes.signup);
          },
          child: const Text(AppMessages.profileTitle),
        )
      ],
    );
  }
}
