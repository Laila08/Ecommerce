import 'package:flutter/material.dart';
import '../components/widgets/app_header.dart';
import '../utils/app_messages.dart';
import 'widgets/profile_widwts/profile_content.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: SingleChildScrollView(
        child: Column(
          spacing: 16,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppHeader(title:AppMessages.profileTitle),
            ProfileContent(),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
