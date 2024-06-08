import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/my_assets.dart';
import '../home_tab/widgets/custom_search_with_shopping_cart.dart';

class FavoriteTab extends StatelessWidget {
  const FavoriteTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(
                width: 150,
                MyAssets.logo,
              ),
            ),
            SizedBox(
              height: 18.h,
            ),
            CustomSearchWithShoppingCart(),
            SizedBox(
              height: 24.h,
            ),
          ]),
    ));
  }
}
