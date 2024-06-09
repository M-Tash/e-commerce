import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../utils/app_colors.dart';

class ThirdIntroScreen extends StatelessWidget {
  const ThirdIntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            alignment: Alignment(0, -0.1),
            child: Lottie.asset('assets/animations/shipping.json')),
        Container(
          alignment: Alignment(0, 0.4),
          child: Text(
            "Experience lightning-fast shipping with Anubis Market",
            style: TextStyle(
                fontSize: 19,
                color: AppColors.primaryColor,
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }
}
