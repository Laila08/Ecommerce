import 'package:flutter/material.dart';
import '../../../components/widgets/main_button.dart';
import '../../../extensions/app_extentions.dart';

class SaveButton extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;

  const SaveButton({super.key, required this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return MainButton(title: title, onTap: onTap).onlyPadding(topPadding: 20);
  }
}
