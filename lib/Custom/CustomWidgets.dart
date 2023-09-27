import 'package:flutter/material.dart';

class CustomWidgets {
  static ElevatedButton CustomElevatedButton({
    required String text,
    required void Function() onPressed,
    double? textFontSize = 24,
    Color? foreGroundTextColor,
    Color? buttonBackgroundColor,
  }) =>
      ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(buttonBackgroundColor)),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(fontSize: textFontSize, color: foreGroundTextColor),
        ),
      );

  static Widget CustomListTile(
          {required void Function() onTap,
          Widget? title,
          Widget? subtitle,
          Widget? leading,
          Widget? trailing,
          Color? backgroundColor = Colors.blue,
          Color? foregroundColor = Colors.white}) =>
      ListTile(
        onTap: onTap,
        title: title,
        subtitle: subtitle,
        trailing: trailing,
        leading: leading,
        tileColor: backgroundColor,
        textColor: foregroundColor,
      );
}
