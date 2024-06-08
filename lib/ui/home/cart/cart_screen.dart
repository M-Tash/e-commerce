import 'package:e_commerce/domain/di.dart';
import 'package:e_commerce/ui/home/cart/cubit/cart_view_model.dart';
import 'package:e_commerce/ui/home/cart/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import '../../utils/my_colors.dart';
import 'widget/cart_item.dart';

class CartScreen extends StatelessWidget {
  static const String routeName = 'cart-screen';
  CartViewModel viewModel = CartViewModel(
      getCartUseCase: injectGetCartUseCase(),
      deleteItemInCartUseCase: injectDeleteItemInCartUseCase(),
      updateItemInCartUseCase: injectUpdateItemInCartUseCase());

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CartViewModel>(
      create: (context) => viewModel..getCartItems(),
      child: BlocBuilder<CartViewModel, CartStates>(
        builder: (context, state) {
          return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              // Button logic here
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back, color: Theme.of(context).primaryColor),
          ),
          title: Text(
            'Cart',
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: Theme.of(context).primaryColor),
          ),
              ),
              body: state is CartSuccessState
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                              return CartItem(
                                cartEntity: state
                                    .cartResponseEntity.data!.products![index],
                              );
                            },
                            itemCount:
                                state.cartResponseEntity.data!.products!.length,
                          ),
            ),
            Padding(
                          padding: EdgeInsets.only(
                              bottom: 20.h, top: 20.h, left: 16.w, right: 16.w),
                          child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 12.h),
                        child: Text('Total Price',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(color: AppColors.greyColor)),
                      ),
                                  Text(
                                      'EGP ${state.cartResponseEntity.data!.totalCartPrice}',
                                      style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primaryColor)),
                    ],
                  ),
                  InkWell(
                    onTap: () {
                                  //todo: check out
                                  //logic here
                    },
                    child: Container(
                                  height: 70.h,
                                  width: 250.w,
                                  decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.r),
                          color: Theme.of(context).primaryColor),
                      child: Padding(
                        padding: EdgeInsets.only(top: 12.h, bottom: 12.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(
                                          padding: EdgeInsets.only(left: 50.w),
                                          child: Text('Check out',
                                  style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium!
                                                  .copyWith(fontSize: 20)),
                                        ),
                            Padding(
                                          padding: EdgeInsets.only(
                                              left: 27.w, right: 20.w),
                                          child: Icon(Icons.arrow_forward,
                                              size: 30.w,
                                              color: AppColors.whiteColor),
                                        ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
                    )
                  : Center(
                      child: Lottie.asset('assets/animations/loading.json',
                          width: 180),
                    ));
        },
      ),
    );
  }
}
