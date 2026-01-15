import 'package:flutter/material.dart';

import 'widgets/bag_view_widgets/bag_body.dart';

class BagView extends StatelessWidget {
  const BagView({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: BagBody(),
    );
  }
}
