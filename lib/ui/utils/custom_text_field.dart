import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_colors.dart';

class TextFieldItem extends StatelessWidget {
  String fieldName;
  String hintText;
  Widget? suffixIcon;
  bool isObscure;
  bool? isSuffixIcon;
  var keyboardType;

  String? Function(String?)? validator;
  TextEditingController controller;

  TextFieldItem(
      {required this.fieldName,
      required this.hintText,
      this.suffixIcon,
      this.isSuffixIcon,
      this.isObscure = false,
      this.validator,
      required this.controller,
      this.keyboardType = TextInputType.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          fieldName,
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(fontSize: 18.sp, color: AppColors.primaryColor),
          textAlign: TextAlign.start,
        ),
        Padding(
          padding: EdgeInsets.only(top: 10.h, bottom: 5.h),
          child: TextFormField(
            decoration: InputDecoration(
              fillColor: AppColors.whiteColor,
              filled: true,
              suffixIcon: suffixIcon,
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.blueGreyColor),
                  borderRadius: BorderRadius.circular(15.r)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.blueGreyColor),
                  borderRadius: BorderRadius.circular(15.r)),
              errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.blueGreyColor),
                  borderRadius: BorderRadius.circular(15.r)),
              hintText: hintText,
              hintStyle: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: AppColors.greyColor),
            ),
            style: TextStyle(color: AppColors.blackColor),
            validator: validator,
            controller: controller,
            obscureText: isObscure,
            keyboardType: keyboardType,
          ),
        )
      ],
    );
  }
}
