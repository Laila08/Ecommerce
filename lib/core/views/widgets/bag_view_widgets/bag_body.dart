import 'package:flutter/material.dart';

import '../../../extensions/app_extentions.dart';
import 'bag_bloc_content.dart';
import 'bag_header.dart';

class BagBody extends StatelessWidget {
  const BagBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [BagHeader(), BagBlocContent(), SizedBox(height: 20)],
      ).allPading(16),
    );
  }
}