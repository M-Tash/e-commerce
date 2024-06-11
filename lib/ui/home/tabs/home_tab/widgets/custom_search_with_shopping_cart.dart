import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../utils/my_assets.dart';
import '../../../../utils/my_colors.dart';
import '../../../cart/cart_screen.dart';
import 'custom_text_field.dart';

class CustomSearchWithShoppingCart extends StatelessWidget {
  final TextEditingController searchController;
  final ValueChanged<String> onSearchChanged;

  const CustomSearchWithShoppingCart({
    super.key,
    required this.searchController,
    required this.onSearchChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomTextField(
            searchController: searchController,
            onChanged: onSearchChanged,
          ),
        ),
        SizedBox(
          width: 24.w,
        ),
        InkWell(
          onTap: () {
            Navigator.pushNamed(context, CartScreen.routeName);
          },
          child: ImageIcon(
            const AssetImage(MyAssets.shoppingCart),
            size: 28.sp,
            color: AppColors.primaryColor,
          ),
        ),
      ],
    );
  }
}
