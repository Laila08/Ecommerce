// import 'package:ecommerceapp/core/controllers/cart/cart_cubit.dart';
// import 'package:ecommerceapp/core/extensions/app_extentions.dart';
// import 'package:ecommerceapp/core/theme/app_text_styles.dart';
// import 'package:ecommerceapp/core/utils/app_colors.dart';
// import 'package:ecommerceapp/core/models/cart_model.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'circle_icon_widget.dart';
//
// class CartItem extends StatelessWidget {
//   final CartModel product;
//
//   const CartItem({super.key, required this.product});
//
//   @override
//   Widget build(BuildContext context) {
//     final cartCubit = BlocProvider.of<CartCubit>(context);
//     final width = context.width;
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         _itemCard(width,product,cartCubit)
//       ],
//     ).onlyPadding(topPadding: 25);
//   }
// }
// Widget _itemCard(double width,CartModel product,CartCubit cartCubit){
//   return Container(
//     width: width,
//     height: 104,
//     decoration: BoxDecoration(
//       color: AppColors.whiteColor,
//       borderRadius: 16.allBorderRadius,
//     ),
//     child: Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       mainAxisAlignment: MainAxisAlignment.end,
//       children: [
//         ClipRRect(
//           borderRadius: BorderRadiusGeometry.only(
//             topLeft: Radius.circular(16),
//             bottomLeft: Radius.circular(16),
//           ),
//           child: Image.asset(
//             product.productImage,
//             width: 104,
//             height: 104,
//             fit: BoxFit.cover,
//           ),
//         ),
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 product.productName,
//                 style: AppTextStyles.font16BlackWeight400,
//               ),
//               Text.rich(
//                 TextSpan(
//                   children: [
//                     TextSpan(
//                       text: "Color: ",
//                       style: AppTextStyles.font11GrayWeight400,
//                     ),
//                     TextSpan(
//                       text: product.color,
//                       style: AppTextStyles.font11BlackWeight400,
//                     ),
//                     TextSpan(
//                       text: "  Size: ",
//                       style: AppTextStyles.font11GrayWeight400,
//                     ),
//                     TextSpan(
//                       text: product.size,
//                       style: AppTextStyles.font11BlackWeight400,
//                     ),
//                   ],
//                 ),
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   BlocBuilder<CartCubit, CartState>(
//                     bloc: cartCubit,
//                     buildWhen: (previous, current) => current is CartISuccess||current is CartILoading||current is CartIFailed,
//                     builder: (context, state) {
//                       if(state is CartILoading){
//                         return CircularProgressIndicator().center();
//                       }
//                       return CircleIconWidget(
//                         icon: Icons.minimize,
//                         color: AppColors.grayColor,
//                         onTap: ()=>cartCubit.oddQuantity(product),
//                       );
//                     },
//                   ),
//                   10.horizontalSizedBox,
//                   Text(product.quantity.toString(),style: AppTextStyles.font14blackWeight500,),
//                   10.horizontalSizedBox,
//                   CircleIconWidget(
//                     icon: Icons.add,
//                     color: AppColors.grayColor,
//                     onTap: ()=>cartCubit.addQuantity(product),
//                   ),
//                 ],
//               ).onlyPadding(topPadding: 12),
//             ],
//           ).onlyPadding(topPadding: 8, leftPadding: 7),
//         ),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.end,
//           children: [
//             Icon(
//               Icons.more_vert,
//               color: AppColors.grayColor,
//             ).onlyPadding(topPadding: 8),
//             Text(
//               "${product.productPrice * product.quantity}\$",
//               style: AppTextStyles.font14blackWeight500,
//             ).onlyPadding(topPadding: 35),
//           ],
//         ).onlyPadding(rightPadding: 8,topPadding: 8),
//       ],
//     ),
//   );
// }
