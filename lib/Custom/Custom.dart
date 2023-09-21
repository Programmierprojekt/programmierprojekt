import 'package:flutter/material.dart';

class CustomWidgets {
  static ElevatedButton CustomElevatedButton({
    required String text,
    required Function onPressed,
    Color? foreGroundTextColor,
  }) =>
      ElevatedButton(
        onPressed: () => onPressed,
        child: Text(
          text,
          style: TextStyle(fontSize: 24, color: foreGroundTextColor),
        ),
      );
}
