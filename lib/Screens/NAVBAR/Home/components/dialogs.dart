// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart' as dialog;

class Dialogs {
  Future<Object?> successDialog(
      {BuildContext? context, String? contentText, String? titleText}) {
    return dialog.showAnimatedDialog(
      context: context!,
      barrierDismissible: true,
      builder: ((context1) {
        return dialog.ClassicGeneralDialogWidget(
          titleText: titleText,
          contentText: contentText,
          onNegativeClick: () {
            Navigator.of(context1).pop();
          },
        );
      }),
      animationType: dialog.DialogTransitionType.slideFromLeft,
      curve: Curves.fastOutSlowIn,
      duration: Duration(seconds: 1),
    );
  }
}
