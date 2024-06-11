import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import '../../../../../domain/entities/CategoryOrBrandResponseEntity.dart';
import 'category_item.dart';

class CategoriesOrBrandsSection extends StatelessWidget {
  final List<CategoryOrBrandEntity> list;

  const CategoriesOrBrandsSection({super.key, required this.list});

  @override
  Widget build(BuildContext context) {
    if (list.isEmpty) {
      return Center(
        child: Lottie.asset('assets/animations/loading.json', width: 60),
      );
    }

    return SizedBox(
      height: 200.h,
      child: GridView.builder(
        itemCount: list.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return CategoryOrBrandItem(categoryEntity: list[index]);
        },
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
        ),
      ),
    );
  }
}
