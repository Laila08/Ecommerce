import 'package:flutter/material.dart';

import '../../../theme/app_text_styles.dart';

class ProfileHeader extends StatelessWidget {
  final String name;
  final String email;

  const ProfileHeader({super.key, required this.name, required this.email});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 16,
      children: [
        const CircleAvatar(radius: 30, child: Icon(Icons.person_outline_sharp)),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name, style: AppTextStyles.font18BlackWeight400),
            Text(email, style: AppTextStyles.font14GrayWeight500),
          ],
        ),
      ],
    );
  }
}
