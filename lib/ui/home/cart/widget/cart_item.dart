import 'package:e_commerce/ui/home/cart/cubit/cart_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../domain/entities/GetCartResponseEntity.dart';
import '../../../utils/my_assets.dart';
import '../../../utils/my_colors.dart';

class CartItem extends StatelessWidget {
  GetProductsEntity cartEntity;

  CartItem({super.key, required this.cartEntity});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(left: 16.w, right: 16.w, top: 24.h, bottom: 24.h),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.r),
            border: Border.all(width: 1.w, color: AppColors.lightGreyColor)),
        width: 398.w,
        height: 150.h,
        child: Row(children: [
          Container(
            clipBehavior: Clip.antiAlias,
            height: 150.h,
            width: 130.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.r),
            ),
            child: Image.network(cartEntity.product?.imageCover ?? '',
                fit: BoxFit.fill),
          ),
          Expanded(
              child: Padding(
            padding: EdgeInsets.only(left: 8.w, right: 8.w),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 16.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ClipRRect(
                          child: SizedBox(
                            width: 180,
                            child: Text(cartEntity.product?.title ?? '',
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                        color: AppColors.primaryColor,
                                        fontWeight: FontWeight.bold)),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            deleteItem(context);
                          },
                          child: const Icon(
                            Icons.delete_outline,
                            color: AppColors.primaryColor,
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 13.h, bottom: 13.h),
                    child: Row(
                      children: [
                        Text('Count: ${cartEntity.count}',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(color: AppColors.blueGreyColor)),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 10.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('EGP ${cartEntity.price}',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                      color: AppColors.primaryColor,
                                      fontWeight: FontWeight.bold)),
                          Container(
                            height: 100.h,
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius: BorderRadius.circular(
                                50.r,
                              ),
                            ),
                            child: Center(
                              child: Row(
                                children: [
                                  IconButton(
                                    padding: EdgeInsets.zero,
                                    onPressed: () {
                                      int counter = cartEntity.count!.toInt();
                                      counter--;
                                      counter == 0
                                          ? deleteItem(context)
                                          : CartViewModel.get(context)
                                              .updateItemCount(
                                                  cartEntity.product!.id ?? '',
                                                  counter);
                                      //todo: decrement count
                                    },
                                    icon: Icon(
                                      Icons.remove_circle_outline_rounded,
                                      color: AppColors.whiteColor,
                                      size: 28.sp,
                                    ),
                                  ),
                                  Text(
                                    '${cartEntity.count}',
                                    style: TextStyle(
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.whiteColor),
                                  ),
                                  IconButton(
                                    padding: EdgeInsets.zero,
                                    onPressed: () {
                                      int counter = cartEntity.count!.toInt();
                                      counter++;
                                      CartViewModel.get(context)
                                          .updateItemCount(
                                              cartEntity.product!.id ?? '',
                                              counter);
                                      //todo: increment count
                                    },
                                    icon: Icon(
                                      Icons.add_circle_outline_rounded,
                                      color: AppColors.whiteColor,
                                      size: 28.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ]),
          )),
        ]),
      ),
    );
  }

  void deleteItem(BuildContext context) {
    CartViewModel.get(context).deleteItemInCart(cartEntity.product?.id ?? '');
  }
}
