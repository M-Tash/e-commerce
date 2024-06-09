import 'package:e_commerce/ui/intro/widgets/custom_button.dart';
import 'package:e_commerce/ui/intro/widgets/first_intro_screen.dart';
import 'package:e_commerce/ui/intro/widgets/second_intro_screen.dart';
import 'package:e_commerce/ui/intro/widgets/third_intro_screen.dart';
import 'package:e_commerce/ui/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../auth/login/login_screen.dart';

class IntroScreen extends StatefulWidget {
  static const String routeName = 'intro_screen';

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  PageController _controller = PageController();
  bool onLastPage = false;

  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        PageView(
          controller: _controller,
          onPageChanged: (index) {
            setState(() {
              onLastPage = (index == 2);
            });
          },
          children: const [
            FirstIntroScreen(),
            SecondIntroScreen(),
            ThirdIntroScreen(),
          ],
        ),
        Container(
            alignment: const Alignment(0, 0.8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                        context, LoginScreen.routeName);
                  },
                  text: 'skip',
                ),
                SmoothPageIndicator(
                    controller: _controller,
                    count: 3,
                    effect: const WormEffect(
                        activeDotColor: AppColors.primaryColor,
                        dotColor: Colors.grey)),
                onLastPage
                    ? CustomButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, LoginScreen.routeName);
                        },
                        text: 'done',
                      )
                    : CustomButton(
                        onPressed: () {
                          _controller.nextPage(
                              duration: Duration(milliseconds: 500),
                              curve: Curves.easeIn);
                        },
                        text: 'next',
                      ),
              ],
            )),
      ],
    ));
  }
}
