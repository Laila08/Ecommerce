import 'package:flutter/material.dart';

import '../../extensions/app_extentions.dart';
import '../../utils/app_colors.dart';
import '../../theme/app_text_styles.dart';

class MainButton extends StatelessWidget {
  final String? title;
  final void Function()? onTap;
  final Widget? child;
  MainButton({super.key, this.title, this.onTap, this.child}) {
    assert(title != null || child != null);
  }

  @override
  Widget build(BuildContext context) {
    final bool hasChild = child != null && title == null;

    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        width:  hasChild ? 100 : double.infinity,
        padding:title != null ? 14.vPading : 0.vPading,
        decoration: BoxDecoration(
          borderRadius: 25.allBorderRadius,
          color: AppColors.primaryColor,
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryColor.withValues(alpha: 0.25),
              blurRadius: 8,
              spreadRadius: 0,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: title != null
            ? Text(title!, style: AppTextStyles.font15WhiteWeight500).center()
            : child,
      ),
    );
  }
}
