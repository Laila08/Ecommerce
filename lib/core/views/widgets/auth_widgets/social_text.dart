import 'package:flutter/material.dart';

import '../../../components/widgets/social_widget.dart';
import '../../../extensions/app_extentions.dart';
import '../../../theme/app_text_styles.dart';
import '../../../utils/app_assets.dart';
import '../../../utils/app_messages.dart'; // استدعاء AppMessages

class SocialText extends StatelessWidget {
  const SocialText({super.key});
  @override
  Widget build(BuildContext context) {
    return Text(
      AppMessages.signUpWithSocial,
      style: AppTextStyles.font14blackWeight500,
    );
  }
}

class SocialRow extends StatelessWidget {
  const SocialRow({super.key});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SocialWidget(image: AppAssets.gmailImg),
        SocialWidget(image: AppAssets.facebookImg).allPading(15),
      ],
    );
  }
}
