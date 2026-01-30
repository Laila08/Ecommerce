import 'package:ecommerceapp/core/controllers/navigation/navigation_cubit.dart';
import 'package:ecommerceapp/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomNavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final int index;

  const BottomNavItem({
    super.key,
    required this.icon,
    required this.label,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationCubit, int>(
      buildWhen: (prev, curr) => prev == index || curr == index,
      builder: (context, selectedIndex) {
        final isSelected = selectedIndex == index;

        return InkWell(
          onTap: () => context.read<NavigationCubit>().changeIndex(index),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color: isSelected ? Colors.red : Colors.grey,
                size: 24,
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  color: isSelected ?AppColors.errorColor : AppColors.grayColor,
                  fontSize: 12,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
