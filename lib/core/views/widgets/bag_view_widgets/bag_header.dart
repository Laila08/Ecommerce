import 'package:flutter/material.dart';

import '../../../theme/app_text_styles.dart';

class BagHeader extends StatelessWidget {
  const BagHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Align(
          alignment: Alignment.centerRight,
          child: Icon(Icons.search, color: Colors.black, size: 25),
        ),
        Text("My Bag", style: AppTextStyles.font34BlackWeight700),
      ],
    );
  }
}
