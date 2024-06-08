import 'package:e_commerce/domain/di.dart';
import 'package:e_commerce/ui/auth/login/login_screen.dart';
import 'package:e_commerce/ui/auth/register/cubit/register_screen_view_model.dart';
import 'package:e_commerce/ui/auth/register/cubit/states.dart';
import 'package:e_commerce/ui/utils/app_colors.dart';
import 'package:e_commerce/ui/utils/custom_text_field.dart';
import 'package:e_commerce/ui/utils/dialog_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../home/home_screen/home_screen_view.dart';
import '../../utils/shared_preference.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = 'register_screen';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  RegisterScreenViewModel viewModel =
      RegisterScreenViewModel(registerUseCase: injectRegisterUseCase());
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: viewModel,
      listener: (context, state) async {
        if (state is RegisterLoadingState) {
          bool isLoading = true;
        } else if (state is RegisterErrorState) {
          bool isLoading = false;
          DialogUtils.showSnackBar(
              context: context, message: state.errorMessage!);
        } else if (state is RegisterSuccessState) {
          bool isLoading = false;
          SharedPreference.saveData(
              key: 'Token', value: state.authResultEntity.token);
          await Future.delayed(Duration(seconds: 1));
          Navigator.pushReplacementNamed(context, HomeScreen.routeName);
          DialogUtils.showSnackBar(
              context: context,
              message:
                  'Welcome ${state.authResultEntity.userEntity?.name ?? ''}');
        }
      },
      child: ModalProgressHUD(
        blur: 0.7,
        color: Colors.transparent,
        progressIndicator: const CircularProgressIndicator(color: Colors.white),
        inAsyncCall: isLoading,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Container(
            height: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      'assets/images/wallpaper.jpeg',
                    ),
                    fit: BoxFit.fill)),
            child: Column(
              children: [
                SizedBox(
                  height: 85,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: GlassContainer.clearGlass(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(15),
                        topLeft: Radius.circular(15),
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15)),
                    gradient: LinearGradient(
                      colors: [
                        Colors.black.withOpacity(0.1),
                        Colors.blue.withOpacity(0.10)
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    height: 680,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 1.h),
                              child: Form(
                                key: viewModel.formKey,
                                child: Column(
                                  children: [
                                    TextFieldItem(
                                      fieldName: 'Full Name',
                                      hintText: 'enter your name',
                                      controller: viewModel.nameController,
                                      validator: (value) {
                                        if (value == null ||
                                            value.trim().isEmpty) {
                                          return 'please enter your name';
                                        }
                                        return null;
                                      },
                                    ),
                                    TextFieldItem(
                                      fieldName: 'Mobile Number',
                                      hintText: 'enter your mobile no.',
                                      controller: viewModel.phoneController,
                                      keyboardType: TextInputType.phone,
                                      validator: (value) {
                                        if (value == null ||
                                            value.trim().isEmpty) {
                                          return 'please enter your number';
                                        }
                                        if (value.trim().length != 11) {
                                          return 'please enter a valid number';
                                        }
                                        return null;
                                      },
                                    ),
                                    TextFieldItem(
                                      fieldName: 'E-mail address',
                                      hintText: 'enter your email address',
                                      controller: viewModel.emailController,
                                      validator: (value) {
                                        if (value == null ||
                                            value.trim().isEmpty) {
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
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                      isObscure: viewModel.isObscure,
                                      isSuffixIcon: true,
                                      suffixIcon: InkWell(
                                        child: viewModel.isObscure
                                            ? Icon(
                                                Icons.visibility_off,
                                                color: Colors.white,
                                              )
                                            : Icon(
                                                Icons.visibility,
                                                color: Colors.white,
                                              ),
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
                                        if (value == null ||
                                            value.trim().isEmpty) {
                                          return 'please enter your password';
                                        }
                                        if (value.trim().length < 6 ||
                                            value.trim().length > 30) {
                                          return 'password should be >6 & <30';
                                        }
                                        return null;
                                      },
                                    ),
                                    TextFieldItem(
                                      fieldName: 'Confirm Password',
                                      hintText: 'confirm your Password',
                                      controller:
                                          viewModel.confirmPasswordController,
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                      isObscure: viewModel.isObscure,
                                      isSuffixIcon: true,
                                      suffixIcon: InkWell(
                                        child: viewModel.isObscure
                                            ? Icon(
                                                Icons.visibility_off,
                                                color: Colors.white,
                                              )
                                            : Icon(
                                                Icons.visibility,
                                                color: Colors.white,
                                              ),
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
                                        if (value == null ||
                                            value.trim().isEmpty) {
                                          return 'please enter your password';
                                        }
                                        if (value !=
                                            viewModel.passwordController.text) {
                                          return "password doesn't match ";
                                        }
                                        return null;
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 35.h),
                              child: ElevatedButton(
                                onPressed: () {
                                  //todo:register
                                  if (viewModel.formKey.currentState
                                          ?.validate() ==
                                      true) {
                                    viewModel.register();
                                  }
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
                                      'Sign Up',
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
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: TextButton(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, LoginScreen.routeName);
                                  },
                                  child: Text("Already have an account? Log In",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(fontSize: 20.sp))),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
