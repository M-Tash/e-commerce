import 'package:e_commerce/ui/auth/login/login_screen.dart';
import 'package:e_commerce/ui/auth/register/register_screen.dart';
import 'package:e_commerce/ui/home/cart/cart_screen.dart';
import 'package:e_commerce/ui/home/home_screen/home_screen_view.dart';
import 'package:e_commerce/ui/home/product_details/product_details_view.dart';
import 'package:e_commerce/ui/intro/intro_screen.dart';
import 'package:e_commerce/ui/splash/splash_screen.dart';
import 'package:e_commerce/ui/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(430, 932),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: SplashScreen.routeName,
          routes: {
            SplashScreen.routeName: (context) => SplashScreen(),
            IntroScreen.routeName: (context) => IntroScreen(),
            RegisterScreen.routeName: (context) => RegisterScreen(),
            LoginScreen.routeName: (context) => LoginScreen(),
            HomeScreen.routeName: (context) => HomeScreen(),
            ProductDetailsView.routeName: (context) => ProductDetailsView(),
            CartScreen.routeName: (context) => CartScreen(),
            // SplashScreen.routeName:(context)=> SplashScreen(),
            // SplashScreen.routeName:(context)=> SplashScreen(),
            // SplashScreen.routeName:(context)=> SplashScreen(),
          },
          theme: AppTheme.mainTheme,
        );
      },
    );
  }
}
