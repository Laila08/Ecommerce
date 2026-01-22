import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';
import 'main_button.dart';

class LoadingButtonWidget extends StatelessWidget {
  const LoadingButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MainButton(
      child: SizedBox(
        height: 20,
        width: 20,
        child: CircularProgressIndicator.adaptive(
          strokeWidth: 2,
          backgroundColor: AppColors.whiteColor,
        ),
      ),
    );
  }
}
