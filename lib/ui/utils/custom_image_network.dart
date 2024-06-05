import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart'; // Import the package for ScreenUtil

class CustomImageWidget extends StatelessWidget {
  final String url;
  final String animation;
  final BoxFit fit;
  final double height;
  final double width;

  const CustomImageWidget({
    Key? key,
    required this.url,
    required this.animation,
    required this.fit,
    required this.height,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(
      url,
      fit: fit,
      height: height,
      width: width,
      loadingBuilder: (context, child, loadingProgress) =>
          loadingProgress == null
              ? child
              : Center(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Lottie.asset(
                      animation,
                      width: 80,
                      height: 80,
                    ),
                  ),
                ),
    );
  }
}
