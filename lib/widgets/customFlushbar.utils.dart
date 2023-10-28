import 'package:another_flushbar/flushbar.dart';
import 'package:breeds_dogs/utils/theme.utils.dart';
import 'package:flutter/material.dart';

class CustomFlushbar {
  static void showTopFlushbar(
    BuildContext context, {
    String? text,
    Duration duration = const Duration(seconds: 3),
  }) {
    Flushbar(
      flushbarPosition: FlushbarPosition.TOP,
      borderRadius: BorderRadius.circular(10),
      margin: const EdgeInsets.all(10),
      backgroundColor: ThemeUtils.getThemeBackground(),
      messageText: Text(
        text ?? '',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: ThemeUtils.getThemeTitle(),
          fontSize: 17,
        ),
      ),
      duration: duration,
    ).show(context);
  }
}
