import 'package:flutter/material.dart';
import 'widgets/nav_item_widgets/bottom_nav_item.dart';
import '../utils/app_messages.dart';

class BottomNavBar extends StatelessWidget {
  final int selectedIndex;

  const BottomNavBar({super.key, required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(16),
        topRight: Radius.circular(16),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 9),
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            BottomNavItem(icon: Icons.home, label: AppMessages.home, index: 0),
            BottomNavItem(icon: Icons.shop, label: AppMessages.shop, index: 1),
            BottomNavItem(
              icon: Icons.shopping_bag,
              label: AppMessages.bag,
              index: 2,
            ),
            BottomNavItem(
              icon: Icons.favorite_border,
              label: AppMessages.favorites,
              index: 3,
            ),
            BottomNavItem(
              icon: Icons.person_outline,
              label: AppMessages.profile,
              index: 4,
            ),
          ],
        ),
      ),
    );
  }
}
