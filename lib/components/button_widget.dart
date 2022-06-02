import 'package:flutter/material.dart';

ButtonTheme elevatedButton(
    {required VoidCallback onPresses,
    required String text,
    required double winWidth,
    required double height,
    required double textSize,
    required Color color}) {
  return ButtonTheme(
      minWidth: winWidth,
      height: height,
      child: ElevatedButton(
        onPressed: onPresses,
        child: Text(text),
        style: ElevatedButton.styleFrom(
            primary: color,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
            textStyle:
                TextStyle(fontStyle: FontStyle.normal, fontSize: textSize),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
      ));
}
