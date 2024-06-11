import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../utils/app_colors.dart';

class FirstIntroScreen extends StatelessWidget {
  const FirstIntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            alignment: const Alignment(0, -0.1),
            child: Lottie.asset('assets/animations/welcome.json')),
        Container(
          alignment: const Alignment(0, 0.4),
          child: const Text(
            "Welcome To Anubis Market",
            style: TextStyle(
                fontSize: 25,
                color: AppColors.primaryColor,
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }
}
