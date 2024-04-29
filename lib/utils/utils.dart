import 'package:flutter/material.dart';

import '../app/app_keys.dart';

SnackBar buildSnackBar(
        {required String text, Color backgroundColor = Colors.red}) =>
    SnackBar(
      content: Text(text),
      backgroundColor: backgroundColor,
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 3),
    );


extension AppSnackbar on AppKeys {
  static show(snackBar) {
    AppKeys.scaffoldMessengerKey.currentState?.hideCurrentSnackBar();
    AppKeys.scaffoldMessengerKey.currentState?.showSnackBar(snackBar);
  }
}

extension DisplayAmountExtension on double {
  // 0 -> 0
  // 10 -> 10
  // 123 -> 123
  // 1230 -> 1,230
  // 12300 -> 12,300
  // 123040 -> 123,040
  // 750200.2356 -> 750,200.23
  // 12k -> 12k
  // 12  -> 12
  toFixedAmount() {
    return toStringAsFixed(2).replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},');
  }
}
