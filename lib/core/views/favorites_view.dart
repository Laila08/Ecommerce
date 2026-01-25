import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../controllers/favorite/favorite_cubit.dart';
import '../utils/app_colors.dart';
import 'widgets/favorites_view_widgets/favorites_body.dart';

class FavoritesView extends StatefulWidget {
  const FavoritesView({super.key});

  @override
  State<FavoritesView> createState() => _FavoritesViewState();
}
class _FavoritesViewState extends State<FavoritesView> {
  @override
  void initState() {
    super.initState();
    context.read<FavoriteCubit>().clearSelectedCatType();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        actions: [
          IconButton(
            onPressed: null,
            icon: Icon(Icons.search, color: AppColors.blackColor),
          ),
        ],
      ),
      body: const SafeArea(child: FavoritesBody()),
    );
  }
}
