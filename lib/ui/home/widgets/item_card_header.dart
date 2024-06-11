import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ItemCardHeader extends StatefulWidget {
  final String image;

  const ItemCardHeader({
    super.key,
    required this.image,
  });

  @override
  State<ItemCardHeader> createState() => _ItemCardHeaderState();
}

class _ItemCardHeaderState extends State<ItemCardHeader> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(15.r),
          child: Image.asset(
            widget.image,
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }
}
