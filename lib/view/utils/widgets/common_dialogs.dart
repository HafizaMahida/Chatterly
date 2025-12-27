import 'package:flutter/material.dart';
import 'package:chat_app/view/utils/const/app_constants.dart';

/// Helper to show error dialog globally
void showErrorDialog(String message, {bool dismissible = true,Function()? onTap}) {
  if (AppConstants.navigatorKey.currentContext != null) {
    showDialog(
      context: AppConstants.navigatorKey.currentContext!,
      barrierDismissible: dismissible,
      builder: (_) => AlertDialog(
        title: const Text("Error"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              if (onTap != null) {
                onTap();
              } else {
                Navigator.pop(AppConstants.navigatorKey.currentContext!);
              }
            },
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }
}