import 'package:flutter/material.dart';

import '../../../extensions/app_extentions.dart';

class HomeErrorWidget extends StatelessWidget {
  final String error;

  const HomeErrorWidget({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    return Text(error).center();
  }
}
