import 'package:e_commerce/ui/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SecondIntroScreen extends StatelessWidget {
  const SecondIntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          alignment: Alignment(0, -0.1),
          child: Lottie.asset('assets/animations/order.json'),
        ),
        Container(
          alignment: Alignment(0, 0.4),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              "Ordering with Anubis Market is a breeze—just select, click, and go!",
              style: TextStyle(
                  fontSize: 19,
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
        )
      ],
    );
  }
}
