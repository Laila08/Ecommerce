import 'package:flutter/material.dart';

import '../../../utils/app_messages.dart';

class FilterSection extends StatelessWidget {
  const FilterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.filter_list_outlined),
        const SizedBox(width: 7),
        Text(AppMessages.filters),
      ],
    );
  }
}
