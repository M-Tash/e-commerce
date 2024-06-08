import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../utils/my_assets.dart';
import '../../../../utils/my_colors.dart';
import '../../../cart/cart_screen.dart';
import '../../../home_screen/cubit/home_screen_view_model.dart';
import '../../../home_screen/cubit/states.dart';
import 'custom_text_field.dart';

class CustomSearchWithShoppingCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomTextField(),
        ),
        SizedBox(
          width: 24.w,
        ),
        InkWell(
          onTap: () {
            Navigator.pushNamed(context, CartScreen.routeName);
          },
          child: BlocBuilder<HomeScreenViewModel, HomeScreenState>(
            builder: (context, state) {
              return ImageIcon(
                const AssetImage(MyAssets.shoppingCart),
                size: 28.sp,
                color: AppColors.primaryColor,
              );
            },
          ),
        ),
      ],
    );
  }
}
