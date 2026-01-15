// import 'package:flutter/material.dart';
//
// import '../../../components/widgets/app_dialog.dart';
// import '../../../controllers/home/home_cubit.dart';
// import 'category_tabs.dart';
//
// class CategoryBody extends StatelessWidget {
//   final HomeState state;
//
//   const CategoryBody({super.key, required this.state});
//
//   @override
//   Widget build(BuildContext context) {
//     if (state is HomeLoading) {
//       return const Center(child: Text("no data"));
//     }
//
//     if (state is HomeFailed) {
//       return AppDialog(message: state.error);
//     }
//
//     if (state is HomeSuccess) {
//       return CategoryTabs(state: state, menProducts: [], womenProducts: [], kidsProducts: [],);
//     }
//
//     return const SizedBox.shrink();
//   }
// }
