import 'dart:async';

import 'package:e_commerce/ui/auth/login/login_screen.dart';
import 'package:e_commerce/ui/home/home_screen/home_screen_view.dart';
import 'package:e_commerce/ui/utils/shared_preference.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = 'splash_screen';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String? route;

  @override
  void initState() {
    super.initState();
    _initializeAsync();
  }

  Future<void> _initializeAsync() async {
    await SharedPreference.init();
    var user = SharedPreference.getData(key: 'Token');
    if (user == null) {
      route = LoginScreen.routeName;
    } else {
      route = HomeScreen.routeName;
    }

    // Delay navigation by 3 seconds
    Timer(Duration(seconds: 2), () {
      // Ensure that the widget is still mounted before navigating
      if (mounted) {
        Navigator.of(context).pushReplacementNamed(route!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Image.asset(
        'assets/images/SplashScreen.png',
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      ),
    );
  }
}
