import 'package:ecommerceapp/core/extensions/app_extentions.dart';
import 'package:ecommerceapp/core/controllers/home/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'widgets/home_widgets/home_header_widget.dart';
import 'widgets/home_widgets/home_body_widget.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final width = context.width;
    final homeCubit = context.read<HomeCubit>();
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: SingleChildScrollView(
        child: Column(
          children: [
            HomeHeaderWidget(width: width),
            HomeBodyWidget(homeCubit: homeCubit),
          ],
        ),
      ),
    );
  }
}

