// import 'package:ecommerceapp/core/components/widgets/main_button.dart';
// import 'package:ecommerceapp/core/extensions/app_extentions.dart';
// import 'package:ecommerceapp/core/routes/routes.dart';
// import 'package:ecommerceapp/core/theme/app_text_styles.dart';
// import 'package:ecommerceapp/core/models/cart_model.dart';
// import 'package:ecommerceapp/core/views/widgets/bag_view_widgets/cart_item.dart';
// import 'package:flutter/material.dart';
// class CartListWidget extends StatelessWidget {
//   final List<CartModel> products;
//   final double totalPrice;
//   const CartListWidget({super.key, required this.products, required this.totalPrice});
//
//   @override
//   Widget build(BuildContext context) {
//     final heigh = context.heigh;
//     return Column(
//       children: [
//         SizedBox(
//           height: heigh*0.36,
//           child: ListView.builder(
//             itemCount: products.length,
//             itemBuilder: (BuildContext context, int index) =>
//                 CartItem(
//                   product:products[index],
//                 ),
//           ),
//         ),
//         Row(
//           children: [
//             Text("Total amount",style:AppTextStyles.font14GrayWeight500),
//             Spacer(),
//             Text("$totalPrice",style:AppTextStyles.font18BlackWeight400)
//           ],
//         ),
//         MainButton(title: "CHECK OUT",onTap: ()=>context.pushNamed(Routes.checkout),)
//       ],
//     );
//   }
// }
