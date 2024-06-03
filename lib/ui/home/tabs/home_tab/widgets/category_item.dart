import 'package:flutter/material.dart';
import '../../../../../domain/entities/CategoryOrBrandResponseEntity.dart';
import '../../../../utils/my_assets.dart';
import '../../../../utils/my_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 8.h,
        ),
        Expanded(
          flex: 2,
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
