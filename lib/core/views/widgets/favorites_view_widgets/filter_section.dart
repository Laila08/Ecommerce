import 'package:flutter/material.dart';

class FilterSection extends StatelessWidget {
  const FilterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Icon(Icons.filter_list_outlined),
        SizedBox(width: 7),
        Text('Filters'),
      ],
    );
  }
}
