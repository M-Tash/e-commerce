import 'package:flutter/material.dart';
import '../../../utils/my_assets.dart';
import '../../../utils/my_colors.dart';
import '../home_tab/widgets/custom_search_with_shopping_cart.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FavoriteTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 17.w),
      child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10.h,
            ),
            Image.asset(
              MyAssets.logo,
              color: AppColors.primaryColor,
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
