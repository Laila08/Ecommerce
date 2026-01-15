import 'package:flutter/material.dart';

class SortSection extends StatelessWidget {
  const SortSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Icon(Icons.swap_vert_sharp),
        SizedBox(width: 7),
        Text('Price: lowest to high'),
      ],
    );
  }
}
