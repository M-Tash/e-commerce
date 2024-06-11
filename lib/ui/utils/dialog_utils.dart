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
                const CircularProgressIndicator(color: AppColors.whiteColor),
                const SizedBox(
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
      duration: const Duration(milliseconds: 1500),
      backgroundColor: AppColors.primaryColor,
      content: Center(
        child: Text(
          message,
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: Colors.white),
        ),
      ),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      margin: const EdgeInsets.all(16.0),
      elevation: 6.0,
    ));
  }
}
