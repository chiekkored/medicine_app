import 'package:flutter/material.dart';

class CustomTextBold extends StatelessWidget {
  const CustomTextBold({
    super.key,
    required this.text,
    required this.fontSize,
  });

  final String text;
  final double fontSize;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: Colors.grey[800]),
    );
  }
}

class CustomTextNormal extends StatelessWidget {
  const CustomTextNormal({
    super.key,
    required this.text,
    required this.fontSize,
  });

  final String text;
  final double fontSize;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontSize: fontSize, color: Colors.grey[800]),
    );
  }
}
