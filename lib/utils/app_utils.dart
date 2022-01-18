import 'package:flutter/material.dart';

class AppUtils {
  /// Show snack bar
  static void showSnackBar(String message, GlobalKey<ScaffoldState> key,
      {bool isError = false}) {
    if (key == null || key.currentState == null) return;
    if (message.isEmpty) return;

    key.currentState!.showSnackBar(
      getSnackBar(message, isError: isError),
    );
  }

  static SnackBar getSnackBar(String message, {bool isError: false}) {
    return SnackBar(
      content: Text(
        message,
      ),
      backgroundColor: isError ? Colors.red : Colors.black87,
    );
  }
}
