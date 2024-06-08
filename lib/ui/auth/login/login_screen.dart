import 'package:e_commerce/domain/di.dart';
import 'package:e_commerce/ui/auth/login/cubit/login_screen_view_model.dart';
import 'package:e_commerce/ui/auth/login/cubit/states.dart';
import 'package:e_commerce/ui/auth/register/register_screen.dart';
import 'package:e_commerce/ui/home/home_screen/home_screen_view.dart';
import 'package:e_commerce/ui/utils/app_colors.dart';
import 'package:e_commerce/ui/utils/custom_text_field.dart';
import 'package:e_commerce/ui/utils/dialog_utils.dart';
import 'package:e_commerce/ui/utils/shared_preference.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = 'login_screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginScreenViewModel viewModel =
      LoginScreenViewModel(loginUseCase: injectLoginUseCase());
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener(
        bloc: viewModel,
        listener: (context, state) async {
          if (state is LoginLoadingState) {
            setState(() {
              isLoading = true;
            });
          } else if (state is LoginErrorState) {
            setState(() {
              isLoading = false;
            });
            DialogUtils.showSnackBar(
                context: context, message: state.errorMessage!);
          } else if (state is LoginSuccessState) {
            setState(() {
              isLoading = true;
            });
            SharedPreference.saveData(
                key: 'Token', value: state.authResultEntity.token);
            await Future.delayed(Duration(seconds: 1)); // Short delay
            Navigator.pushReplacementNamed(context, HomeScreen.routeName);
            DialogUtils.showSnackBar(
                context: context,
                message:
                    'Welcome Back ${state.authResultEntity.userEntity?.name ?? ''}');
            setState(() {
              isLoading = false;
            });
          }
        },
        child: ModalProgressHUD(
          blur: 0.7,
          color: Colors.transparent,
          progressIndicator:
              const CircularProgressIndicator(color: Colors.white),
          inAsyncCall: isLoading,
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: Container(
              height: double.infinity,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/wallpaper.jpeg'),
                      fit: BoxFit.fill)),
              child: Column(
                children: [
                  SizedBox(
                    height: 200,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: GlassContainer.clearGlass(
                      blur: 5,
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
                      height: 500,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Welcome Back',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(fontSize: 24.sp),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 30.h),
                                child: Form(
                                  key: viewModel.formKey,
                                  child: Column(
                                    children: [
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
                                        controller:
                                            viewModel.passwordController,
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
                                            setState(() {
                                              viewModel.isObscure =
                                                  !viewModel.isObscure;
                                            });
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
                                                    .copyWith(
                                                        fontSize: 20.sp))),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 35.h),
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (viewModel.formKey.currentState
                                            ?.validate() ==
                                        true) {
                                      viewModel.login();
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(15.r),
                                      ),
                                    ),
                                  ),
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
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: TextButton(
                                    onPressed: () {
                                      Navigator.pushNamed(
                                          context, RegisterScreen.routeName);
                                    },
                                    child: Text(
                                        "Don't have an account? Create Account",
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
        ));
  }
}

