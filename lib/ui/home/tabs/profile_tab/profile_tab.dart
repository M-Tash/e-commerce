import 'package:e_commerce/ui/auth/login/login_screen.dart';
import 'package:e_commerce/ui/utils/shared_preference.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/custome_text_field_item.dart';
import '../../../utils/my_assets.dart';
import '../../../utils/my_colors.dart';

class ProfileTab extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var passwordController = TextEditingController();
  var addressController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  bool isObsecure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Form(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.asset(
                            width: 150,
                            MyAssets.logo,
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              SharedPreference.removeData(key: 'Token');
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  LoginScreen.routeName, (route) => false);
                            },
                            icon: Icon(
                              Icons.logout,
                              color: AppColors.primaryColor,
                            ))
                      ],
                    ),
                    SizedBox(
                      height: 18.h,
                    ),
                    Text(
                      "WELCOME, MARIAM",
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: AppColors.primaryColor),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Text(
                      "Mariam@gmail.com",
                      style: TextStyle(color: AppColors.blueGreyColor),
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    CustomTextFieldItem(
                      fieldName: 'Your Full Name',
                      hintText: 'Mariam mahmoud hafez',
                      controller: nameController,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'please enter full name';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.text,
                      suffixIconFunction: () {},
                    ),
                    CustomTextFieldItem(
                      fieldName: 'Your E-mail',
                      hintText: 'Mariam@gmail.com',
                      controller: emailController,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'please enter your email address';
                        }
                        bool emailValid = RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(value);
                        if (!emailValid) {
                          return 'invalid email';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      suffixIconFunction: () {},
                    ),
                    CustomTextFieldItem(
                      fieldName: 'Your Password',
                      hintText: '********',
                      controller: passwordController,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'please enter password';
                        }
                        if (value.trim().length < 6 ||
                            value.trim().length > 30) {
                          return 'password should be >6 & <30';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.text,
                      suffixIconFunction: () {},
                    ),
                    CustomTextFieldItem(
                      fieldName: 'Your Mobile Number',
                      hintText: '01021212121',
                      controller: phoneController,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'please enter your mobile no';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.text,
                      suffixIconFunction: () {},
                    ),
                    CustomTextFieldItem(
                      fieldName: 'Your Address',
                      hintText: 'Address',
                      controller: addressController,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'please enter address';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.text,
                      suffixIconFunction: () {},
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
