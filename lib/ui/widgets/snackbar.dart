import 'package:flutter/material.dart';

class SnackBarWidget {
  static SnackBar snackBar({
    required String title,
    required Color color,
  }) {
    return SnackBar(
      content: Text(title),
      backgroundColor: color,
      duration: Duration(seconds: 5),
    );
  }
}
