import 'package:flutter/material.dart';

import '../extensions/app_extentions.dart';

String documentidFromLocalData() => DateTime.now().toIso8601String();
const double kCupertinoNavigationBarHeight = 44.0;
enum ViewMode { list, grid }

double calculateChildAspectRatio(BuildContext context, double itemHeight) {
  final totalSpacing = 16 * 3;
  final itemWidth = (context.width - totalSpacing) / 2;
  return itemWidth / itemHeight;
}

List<String> getImageList(String gender) {
  if (gender == "Women") {
    return [
      "assets/images/New.png",
      "assets/images/Clothes.png",
      "assets/images/Shoes.png",
      "assets/images/Accesories.png",
    ];
  } else if (gender == "Men") {
    return [
      "https://nextluxury.com/wp-content/uploads/Top-15-Fashion-Accessories-For-Men-1.jpg",
      "https://n.nordstrommedia.com/is/image/nordstrom/MENS_CLS03F_0126_1916_altBgd_ext_8-5.jpeg?width=240&dpr=2&crop=5079.2%3A6349%2Coffset-x52.747%2Coffset-y50&trim=0%2C0.009%2C0%2C0",
      "https://hips.hearstapps.com/hmg-prod/images/1-indexl-694ac08d51134.jpg",
      "https://cdn.justluxe.com/articles/images/news/shutterstock_335426435.jpg",
    ];
  } else {
    return [
      "https://putthison.com/wp-content/uploads/2019/10/kw-brunellocucinelli-aw19-5-1563x1000.jpg",
      "https://image.made-in-china.com/202f0j00gvehwtBCZVUP/2024-New-Arrival-Fashion-Spring-Autumn-Boys-2-Pieces-Casual-Clothing-Set-Full-Sleeves-T-Shirt-Pants-for-Kids.jpg",
      "https://littlecharlie.in/cdn/shop/products/H984fe25338c345928fd1b0345500d6608_1445x.jpg?v=1645580411",
      "https://www.chouetteetpapillon.com/wp-content/uploads/2021/06/c_136-Selection-enfant-1024x1024.jpg",
    ];
  }
}
