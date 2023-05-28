import 'package:flutter/material.dart';

class ShowSnackBar {
  void showSuccessOrErrorMessageSnackBar(BuildContext context, String message ,Color color) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        message,
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: color,
    ));
  }
}
