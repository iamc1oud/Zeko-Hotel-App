import 'package:flutter/material.dart';
import 'package:zeko_hotel_crm/main.dart';

void showSnackbar(String? text) {
  // Remove spamming of snackbars.
  ScaffoldMessenger.of(navigatorKey.currentContext!).clearSnackBars();

  ScaffoldMessenger.of(navigatorKey.currentContext!)
      .showSnackBar(SnackBar(content: Text('$text')));
}
