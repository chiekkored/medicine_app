import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Show Custom Dialog depending on user's device platform
///
/// This function accepts four parameters: [BuildContent] `context` for the Widget's
/// context, [String] `title` for the popups title, [String] `content` for the popup's
/// display content, and [String] `buttonText` for the text close button of the
/// popup.
void customShowCustomDialog(BuildContext context,
    {required String title,
    required String content,
    required String buttonText}) {
  if (Platform.isIOS) {
    showCupertinoDialog(
        context: context,
        builder: ((context) {
          return CupertinoAlertDialog(
            title: Text(title),
            content: Text(content),
            actions: [
              CupertinoDialogAction(
                child: Text(buttonText),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        }));
  } else {
    showDialog(
        context: context,
        builder: ((context) {
          return AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: [
              TextButton(
                child: Text(buttonText),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        }));
  }
}
