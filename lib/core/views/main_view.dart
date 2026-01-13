import 'package:ecommerceapp/core/controllers/cart/cart_cubit.dart';
import 'package:ecommerceapp/core/controllers/navigation_controller.dart';
import 'package:ecommerceapp/core/utils/app_colors.dart';
import 'package:ecommerceapp/core/controllers/home/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'bag_view.dart';
import 'category_view.dart';
import 'favorites_view.dart';
import 'home_view.dart';

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    final navController = Provider.of<NavigationController>(context);

    final List<Widget> pages = [
      HomeView(),
      CategoryView(),
      BlocProvider(
        create: (context) => CartCubit()..getCartProducts(),
        child: BagView(),
      ),
      BlocProvider(
        create: (context) => CartCubit()..getCartProducts(),
        child: FavoritesView(),
      ),

      BagView(),
    ];

    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      body: pages[navController.selectedIndex],

      bottomNavigationBar: ClipRRect(
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
              _buildNavItem(context, Icons.home, "Home", 0),
              _buildNavItem(context, Icons.shop, "Shop", 1),
              _buildNavItem(context, FontAwesomeIcons.bagShopping, "Bag", 2),
              _buildNavItem(context, Icons.favorite_border, "Favorites", 3),
              _buildNavItem(context, Icons.person_outline, "Profile", 4),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(BuildContext context,
      IconData icon,
      String label,
      int index,) {
    final navController = Provider.of<NavigationController>(context);
    final isSelected = navController.selectedIndex == index;

    return GestureDetector(
      onTap: () => navController.changeIndex(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: isSelected ? Colors.red : Colors.grey, size: 24),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.red : Colors.grey,
              fontSize: 12,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
