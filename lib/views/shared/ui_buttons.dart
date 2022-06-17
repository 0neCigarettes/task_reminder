import 'package:flutter/material.dart';

Widget roundedIconButton({
  required void Function() onPressed,
  required bool onSwitch,
  EdgeInsets padding = const EdgeInsets.all(20),
  Color primaryColor = Colors.white,
  Color onSwitchTrueColor = Colors.lightBlue,
  Color onSwitchFalseColor = Colors.red,
}) {
  return OutlinedButton(
    onPressed: () {
      onPressed();
    },
    child: Icon(Icons.power_settings_new,
        color: onSwitch ? onSwitchTrueColor : onSwitchFalseColor),
    style: ElevatedButton.styleFrom(
      shape: CircleBorder(),
      padding: padding,
      primary: primaryColor,
      side: BorderSide(
          color: onSwitch
              ? onSwitchTrueColor
              : onSwitchFalseColor), // <-- Splash color
    ),
  );
}

Widget textButtonOutlined(
    {required void Function() onPressed,
    required String text,
    double fontSize = 16,
    double padding = 15,
    Color foregroundColor = Colors.blue,
    Color outlineColor = Colors.blue}) {
  return TextButton(
      onPressed: () {
        onPressed();
      },
      child: Text(text.toUpperCase(), style: TextStyle(fontSize: fontSize)),
      style: ButtonStyle(
          padding:
              MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(padding)),
          foregroundColor: MaterialStateProperty.all<Color>(foregroundColor),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: BorderSide(color: outlineColor)))));
}
