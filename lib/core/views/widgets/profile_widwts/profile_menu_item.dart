import 'package:flutter/material.dart';

import '../../../theme/app_text_styles.dart';
import '../../../utils/app_colors.dart';

class ProfileMenuItem extends StatelessWidget {
  final String title;
  final String subtitle;

  const ProfileMenuItem({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          trailing: Icon(
            Icons.arrow_forward_ios_sharp,
            color: AppColors.grayColor,
            size: 15,
          ),
          title: Text(title, style: AppTextStyles.font16BlackWeight400),
          subtitle: Text(subtitle, style: AppTextStyles.font11GrayWeight400),
        ),
        Divider(
          color: AppColors.grayColor.withValues(alpha: 0.05),
          height: 1,
          thickness: 1,
        ),
      ],
    );
  }
}