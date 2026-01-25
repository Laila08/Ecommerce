import 'package:ecommerceapp/core/controllers/cart/cart_cubit.dart';
import 'package:ecommerceapp/core/utils/app_colors.dart';
import 'package:ecommerceapp/core/views/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../controllers/navigation/navigation_cubit.dart';
import 'bag_view.dart';
import 'bottom_nav_bar.dart';
import 'category_view.dart';
import 'favorites_view.dart';
import 'home_view.dart';

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    final navCubit = context.read<NavigationCubit>();
    final int? initialIndex =
        ModalRoute.of(context)?.settings.arguments as int?;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (initialIndex != null && navCubit.state == 0) {
        navCubit.changeIndex(initialIndex);
      }
    });

    final List<Widget> pages = [
      HomeView(),
      CategoryView(),
      // BlocProvider(
      //   create: (_) => CartCubit()..getCartProducts(),
      //   child: BagView(),
      // ),
      BagView(),
      FavoritesView(),
      ProfileView(),
    ];

    return BlocBuilder<NavigationCubit, int>(
      builder: (context, selectedIndex) {
        return Scaffold(
          backgroundColor: AppColors.backGroundColor,
          body: pages[selectedIndex],
          bottomNavigationBar: BottomNavBar(selectedIndex: selectedIndex),
        );
      },
    );
  }
}
