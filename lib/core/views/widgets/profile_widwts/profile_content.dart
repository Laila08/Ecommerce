
import 'package:flutter/material.dart';

import '../../../extensions/app_extentions.dart';
import 'profile_header.dart';
import 'profile_menu_item.dart';

class ProfileContent extends StatelessWidget {
  const ProfileContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ProfileHeader(
          name: "Matilda Brown",
          email: "matildabrown@mail.com",
        ).onlyPadding(bottomPadding: 20, leftPadding: 15),

        ProfileMenuItem(
          title: "My orders",
          subtitle: "Already have 12 orders",
        ),
        ProfileMenuItem(
          title: "Shipping addresses",
          subtitle: "3 addresses",
        ),
        ProfileMenuItem(
          title: "Payment methods",
          subtitle: "Visa  **34",
        ),
        ProfileMenuItem(
          title: "Promo codes",
          subtitle: "You have special promo codes",
        ),
        ProfileMenuItem(
          title: "My reviews",
          subtitle: "Reviews for 4 items",
        ),
        ProfileMenuItem(
          title: "Settings",
          subtitle: "Notifications, password",
        ),
      ],
    );
  }
}
// import 'package:ecommerceapp/core/theme/app_text_styles.dart';
// import 'package:ecommerceapp/core/utils/app_colors.dart';
// import 'package:flutter/material.dart';
//
// import '../../../extensions/app_extentions.dart';
//
// class ProfileContent extends StatelessWidget {
//   const ProfileContent({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           spacing: 16,
//           children: [
//             CircleAvatar(radius: 30, child: Icon(Icons.person_outline_sharp)),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   "Matilda Brown",
//                   style: AppTextStyles.font18BlackWeight400,
//                 ),
//                 Text(
//                   "matildabrown@mail.com",
//                   style: AppTextStyles.font14GrayWeight500,
//                 ),
//               ],
//             ),
//           ],
//         ).onlyPadding(bottomPadding: 20,leftPadding: 15),
//         ListTile(
//           trailing: Icon(
//             Icons.arrow_forward_ios_sharp,
//             color: AppColors.grayColor,
//             size: 15,
//           ),
//           title: Text("My orders", style: AppTextStyles.font16BlackWeight400),
//           subtitle: Text(
//             "Already have 12 orders",
//             style: AppTextStyles.font11GrayWeight400,
//           ),
//         ),
//         Divider(color: AppColors.grayColor.withValues(alpha: 0.05),height: 1, thickness: 1,),
//         ListTile(
//           trailing: Icon(
//             Icons.arrow_forward_ios_sharp,
//             color: AppColors.grayColor,
//             size: 15,
//           ),
//           title: Text(
//             "Shipping addresses",
//             style: AppTextStyles.font16BlackWeight400,
//           ),
//           subtitle: Text(
//             "3 addresses",
//             style: AppTextStyles.font11GrayWeight400,
//           ),
//         ),
//         Divider(color: AppColors.grayColor.withValues(alpha: 0.05),height: 1, thickness: 1,),
//
//         ListTile(
//           trailing: Icon(
//             Icons.arrow_forward_ios_sharp,
//             color: AppColors.grayColor,
//             size: 15,
//           ),
//           title: Text(
//             "Payment methods",
//             style: AppTextStyles.font16BlackWeight400,
//           ),
//           subtitle: Text(
//             "Visa  **34",
//             style: AppTextStyles.font11GrayWeight400,
//           ),
//         ),
//         Divider(color: AppColors.grayColor.withValues(alpha: 0.05),height: 1, thickness: 1,),
//
//         ListTile(
//           trailing: Icon(
//             Icons.arrow_forward_ios_sharp,
//             color: AppColors.grayColor,
//             size: 15,
//           ),
//           title: Text("Promo codes", style: AppTextStyles.font16BlackWeight400),
//           subtitle: Text(
//             "You have special promo codes",
//             style: AppTextStyles.font11GrayWeight400,
//           ),
//         ),
//         Divider(color: AppColors.grayColor.withValues(alpha: 0.05),height: 1, thickness: 1,),
//
//         ListTile(
//           trailing: Icon(
//             Icons.arrow_forward_ios_sharp,
//             color: AppColors.grayColor,
//             size: 15,
//           ),
//           title: Text("My reviews", style: AppTextStyles.font16BlackWeight400),
//           subtitle: Text(
//             "Reviews for 4 items",
//             style: AppTextStyles.font11GrayWeight400,
//           ),
//         ),
//         Divider(color: AppColors.grayColor.withValues(alpha: 0.05),height: 1, thickness: 1,),
//
//         ListTile(
//           trailing: Icon(
//             Icons.arrow_forward_ios_sharp,
//             color: AppColors.grayColor,
//             size: 15,
//           ),
//           title: Text("Settings", style: AppTextStyles.font16BlackWeight400),
//           subtitle: Text(
//             "Notifications, password",
//             style: AppTextStyles.font11GrayWeight400,
//           ),
//         ),
//       ],
//     );
//   }
// }
