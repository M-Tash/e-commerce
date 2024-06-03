import 'package:flutter/material.dart';

import 'app_colors.dart';

class DialogUtils {
  static void showLoading(
      {required BuildContext context,
      required String message,
      bool isDismissible = true}) {
    showDialog(
        context: context,
        barrierDismissible: isDismissible,
        builder: (context) {
          return AlertDialog(
            backgroundColor: AppColors.blueColor,
            content: Row(
              children: [
                CircularProgressIndicator(color: AppColors.whiteColor),
                SizedBox(
                  width: 12,
                ),
                Text(message)
              ],
            ),
          );
        });
  }

  static void hideLoading({required BuildContext context}) {
    Navigator.pop(context);
  }

  static void showSnackBar({
    required BuildContext context,
    required String message,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: AppColors.blueColor,
        content: Center(
            child: Text(
          message,
          style: Theme.of(context).textTheme.bodyLarge,
        ))));
  }
}
