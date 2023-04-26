import 'package:flutter/material.dart';

/// Custom Bold Text.
///
/// This Widget accepts two parameters: [String] `text` for the display text, and
/// [double] `fontSize` for the size of the text.
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

/// Custom Normal Text.
///
/// This Widget accepts two parameters: [String] `text` for the display text, and
/// [double] `fontSize` for the size of the text.
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
