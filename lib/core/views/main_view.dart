import 'package:ecommerceapp/core/controllers/cart/cart_cubit.dart';
import 'package:ecommerceapp/core/controllers/checkout/shipping_address/shipping_address_cubit.dart';
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
    if (initialIndex != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        navCubit.changeIndex(initialIndex);
      });
    }
    final List<Widget> pages = [
      HomeView(),
      CategoryView(),
      MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => CartCubit()..getCartProducts()),
          BlocProvider(
            create: (context) => ShippingAddressCubit()..getShippingAddresses(),
          ),
        ],
        child: BagView(),
      ),
      BlocProvider(
        create: (context) => CartCubit()..getCartProducts(),
        child: FavoritesView(),
      ),
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
