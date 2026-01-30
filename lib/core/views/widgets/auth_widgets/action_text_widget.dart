import 'package:ecommerceapp/core/extensions/app_extentions.dart';
import 'package:ecommerceapp/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class ActionTextWidget extends StatelessWidget {
  const ActionTextWidget({
    super.key,
    required this.title,
    required this.routeName,
  });
  final String title;
  final String routeName;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.pushNamed(routeName);
      },
      child: Align(
        alignment: Alignment.bottomRight,
        child: Text(title, style: AppTextStyles.font14blackWeight500),
      ),
    );
  }
}
