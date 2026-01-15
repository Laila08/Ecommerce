import 'package:flutter/material.dart';

import '../../extensions/app_extentions.dart';

class FailedStateWidget extends StatelessWidget {
  final String text;
  const FailedStateWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(text).center();
  }
}
