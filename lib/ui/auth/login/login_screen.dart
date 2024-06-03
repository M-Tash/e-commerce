import 'package:e_commerce/domain/di.dart';
import 'package:e_commerce/ui/auth/login/cubit/login_screen_view_model.dart';
import 'package:e_commerce/ui/auth/login/cubit/states.dart';
import 'package:e_commerce/ui/auth/register/register_screen.dart';
import 'package:e_commerce/ui/home/home_screen/home_screen_view.dart';
import 'package:e_commerce/ui/utils/app_colors.dart';
import 'package:e_commerce/ui/utils/custom_text_field.dart';
import 'package:e_commerce/ui/utils/dialog_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = 'login_screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginScreenViewModel viewModel =
      LoginScreenViewModel(loginUseCase: injectLoginUseCase());

  @override
  Widget build(BuildContext context) {
    return BlocListener(
        bloc: viewModel,
        listener: (context, state) {
          if (state is LoginLoadingState) {
            DialogUtils.showLoading(context: context, message: 'Loading..');
          } else if (state is LoginErrorState) {
            DialogUtils.hideLoading(context: context);
            DialogUtils.showSnackBar(
                context: context, message: state.errorMessage!);
          } else if (state is LoginSuccessState) {
            DialogUtils.hideLoading(context: context);
            Navigator.pushReplacementNamed(context, HomeScreen.routeName);
            DialogUtils.showSnackBar(
                context: context,
                message: state.authResultEntity.userEntity?.name ?? '');
          }
        },
        child: Scaffold(
          body: Container(
            color: Theme.of(context).primaryColor,
            height: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                      padding: EdgeInsets.only(
                          top: 100.h, bottom: 46.h, left: 97.w, right: 97.w),
                      child: Text('Logo')),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Welcome Back',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(fontSize: 24.sp),
                        ),
                        Text(
                          'Please sign in with your mail',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(fontSize: 16.sp),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 40.h),
                          child: Form(
                            key: viewModel.formKey,
                            child: Column(
                              children: [
                                TextFieldItem(
                                  fieldName: 'E-mail address',
                                  hintText: 'enter your email address',
                                  controller: viewModel.emailController,
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
                                ),
                                TextFieldItem(
                                  fieldName: 'Password',
                                  hintText: 'enter your Password',
                                  controller: viewModel.passwordController,
                                  keyboardType: TextInputType.visiblePassword,
                                  isObscure: viewModel.isObscure,
                                  isSuffixIcon: true,
                                  suffixIcon: InkWell(
                                    child: viewModel.isObscure
                                        ? Icon(Icons.visibility_off)
                                        : Icon(Icons.visibility),
                                    onTap: () {
                                      if (viewModel.isObscure) {
                                        viewModel.isObscure = false;
                                      } else {
                                        viewModel.isObscure = true;
                                      }
                                      setState(() {});
                                    },
                                  ),
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return 'please enter your password';
                                    }
                                    if (value.trim().length < 6 ||
                                        value.trim().length > 30) {
                                      return 'password should be >6 & <30';
                                    }
                                    return null;
                                  },
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 200.w),
                                  child: TextButton(
                                      onPressed: () {
                                        //todo:forget password
                                      },
                                      child: Text("Forgot Password",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium!
                                              .copyWith(fontSize: 20.sp))),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 35.h),
                          child: ElevatedButton(
                            onPressed: () {
                              //todo:login
                              viewModel.login();
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.whiteColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(15.r)))),
                            child: SizedBox(
                              height: 64.h,
                              width: 398.w,
                              child: Center(
                                child: Text(
                                  'Login',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(
                                          color: AppColors.primaryColor,
                                          fontSize: 20.sp),
                                ),
                              ),
                            ),
                          ),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, RegisterScreen.routeName);
                            },
                            child: Text("Don't have an account? Create Account",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(fontSize: 20.sp)))
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
