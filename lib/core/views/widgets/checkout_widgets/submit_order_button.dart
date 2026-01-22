import 'package:ecommerceapp/core/extensions/app_extentions.dart';
import 'package:flutter/material.dart';

import '../../../components/widgets/main_button.dart';

class SubmitOrderButton extends StatelessWidget {
  const SubmitOrderButton({super.key});

  @override
  Widget build(BuildContext context) {
    return MainButton(title: "SUBMIT ORDER").onlyPadding(topPadding: 30);
  }
}
