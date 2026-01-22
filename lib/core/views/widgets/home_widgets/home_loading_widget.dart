import 'package:ecommerceapp/core/extensions/app_extentions.dart';
import 'package:flutter/material.dart';

class HomeLoadingWidget extends StatelessWidget {
  const HomeLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator().center().allPading(50);
  }
}
