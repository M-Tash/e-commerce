import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import '../../../../../domain/entities/CategoryOrBrandResponseEntity.dart';
import '../../../../utils/my_colors.dart';

class CategoryOrBrandItem extends StatelessWidget {
  final CategoryOrBrandEntity categoryEntity;

  CategoryOrBrandItem({required this.categoryEntity});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 8,
          child: AspectRatio(
            aspectRatio: 1,
            child: CircleAvatar(
              radius: 50.r,
              backgroundColor: Colors.transparent,
              child: ClipOval(
                child: Image.network(
                  categoryEntity.image ?? '',
                  fit: BoxFit.fill,
                  width: double.infinity,
                  height: double.infinity,
                  loadingBuilder: (context, child, loadingProgress) =>
                      loadingProgress == null
                          ? child
                          : Center(
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Lottie.asset(
                                  'assets/animations/loading.json',
                                  width: 50,
                                  height: 50,
                                ),
                              ),
                            ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 8.h,
        ),
        Expanded(
          flex: 3,
          child: Text(
            categoryEntity.name ?? '',
            textWidthBasis: TextWidthBasis.longestLine,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontSize: 14.sp,
                  color: AppColors.darkPrimaryColor,
                  fontWeight: FontWeight.normal,
                ),
          ),
        ),
      ],
    );
  }
}
