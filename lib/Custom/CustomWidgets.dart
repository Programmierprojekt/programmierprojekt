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

  static Future<T?> showTextfieldDialog<T>(
      BuildContext context,
      ThemeData theme,
      String currentTitle,
      String dialogTitle,
      void Function(String) onSubmit
    ) {
    return showDialog(
      context: context,
      builder: (context) {
        String savedText = "";

        return AlertDialog(
          title: Text(dialogTitle),
          content: TextField(
            autofocus: true,
            onChanged: (newText) {
              savedText = newText;
            },
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              label: Text(currentTitle),
            ),
            onSubmitted: (value) {
              onSubmit(savedText);
              Navigator.of(context).pop();
            },
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: theme.textTheme.labelLarge,
              ),
              child: const Text("Abbrechen"),
              onPressed:() {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: theme.textTheme.labelLarge,
              ),
              child: const Text("Speichern"),
              onPressed: () {
                onSubmit(savedText);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      }
    );
  }

  static Future<T?> showAlertDialog<T>(
    BuildContext context,
    ThemeData theme,
    String dialogTitle,
    String dialogContent
  ) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(dialogTitle),
          content: Text(dialogContent),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: theme.textTheme.labelLarge,
              ),
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      }
    );
  }
}
