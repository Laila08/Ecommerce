import 'package:ecommerceapp/core/utils/app_messages.dart';
import 'package:flutter/material.dart';

class EmptyProductsView extends StatelessWidget {
  const EmptyProductsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(AppMessages.noProduct),
    );
  }
}