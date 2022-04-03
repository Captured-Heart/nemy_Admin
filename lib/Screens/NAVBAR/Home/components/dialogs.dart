// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart' as dialog;

class Dialogs {
  Future<Object?> successDialog({
    BuildContext? context,
    String? contentText,
    String? titleText,
    
  }) {
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

  Future<Object?> warningDialog(
      { required BuildContext context,
      String? contentText,
      String? titleText,
      required VoidCallback onPositiveClick}) {
    return dialog.showAnimatedDialog(
      context: context,
      barrierDismissible: true,
      builder: ((context1) {
        return dialog.ClassicGeneralDialogWidget(
          titleText: titleText,
          contentText: contentText,
          onNegativeClick: () {
            Navigator.of(context1).pop();
          },
          onPositiveClick: onPositiveClick,
        );
      }),
      animationType: dialog.DialogTransitionType.slideFromLeft,
      curve: Curves.fastOutSlowIn,
      duration: Duration(seconds: 1),
    );
  }

  Future<Object?> popUntilDialog(
      {BuildContext? context,
      String? contentText,
      String? titleText,
      String? pageName}) {
    return dialog.showAnimatedDialog(
      context: context!,
      barrierDismissible: true,
      builder: ((context2) {
        return dialog.ClassicGeneralDialogWidget(
          titleText: titleText,
          contentText: contentText,
          onNegativeClick: () {
            Navigator.of(context2).popUntil(ModalRoute.withName(pageName!));
          },
        );
      }),
      animationType: dialog.DialogTransitionType.slideFromLeft,
      curve: Curves.fastOutSlowIn,
      duration: Duration(seconds: 2),
    );
  }

  Future<Object?> pushToDialog(
      {BuildContext? context,
      String? contentText,
      String? titleText,
      String? pageName}) {
    return dialog.showAnimatedDialog(
      context: context!,
      barrierDismissible: true,
      builder: ((context2) {
        return dialog.ClassicGeneralDialogWidget(
          titleText: titleText,
          contentText: contentText,
          onNegativeClick: () {
            Navigator.of(context2).popAndPushNamed(pageName!);
          },
        );
      }),
      animationType: dialog.DialogTransitionType.slideFromLeft,
      curve: Curves.fastOutSlowIn,
      duration: Duration(seconds: 2),
    );
  }

  Future<Object?> popUntil2Dialog(
      {BuildContext? context,
      String? contentText,
      String? titleText,
      VoidCallback? onNegativeClick}) {
    return dialog.showAnimatedDialog(
      context: context!,
      barrierDismissible: true,
      builder: ((context2) {
        return dialog.ClassicGeneralDialogWidget(
            titleText: titleText,
            contentText: contentText,
            onNegativeClick: onNegativeClick);
      }),
      animationType: dialog.DialogTransitionType.slideFromLeft,
      curve: Curves.fastOutSlowIn,
      duration: Duration(seconds: 2),
    );
  }

  Future<void> addFolder({
    BuildContext? context,
    TextEditingController? folderTextEditingController,
    TextEditingController? descTextEditingController,
    TextEditingController? typeTextEditingController,
    VoidCallback? onPressedSave,
    // Widget? iconWidget,
    // textWidget,
    required GlobalKey formKeyLeftAbout,
  }) {
    var alert = StatefulBuilder(
      builder: (context, setState) {
        return AlertDialog(
          content: Form(
            key: formKeyLeftAbout,
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.42,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Column(
                    //   crossAxisAlignment: CrossAxisAlignment.center,
                    //   children: [
                    //     Container(
                    //       color: Colors.grey[200],
                    //       padding: EdgeInsets.all(5),
                    //       height: MediaQuery.of(context).size.height * 0.12,
                    //       width: MediaQuery.of(context).size.width * 0.3,
                    //       // child: iconWidget,
                    //     ),
                    //     // textWidget
                    //   ],
                    // ),
                    Row(
                      children: <Widget>[
                        Expanded(
                            child: TextFormField(
                          controller: folderTextEditingController,
                          autofocus: true,
                          decoration: InputDecoration(
                            hintText: 'folder Name',
                            icon: Icon(Icons.folder),
                          ),
                          maxLength: 25,
                          validator: (text) {
                            return text!.isEmpty
                                ? 'The Field can not be empty'
                                : null;
                          },
                          // validator: MultiValidator([
                          //   RequiredValidator(errorText: 'field must not be empty'),
                          //   MaxLengthValidator(25, errorText: 'Not more than 255 words'),
                          // ]),
                        )),
                      ],
                    ),
                    TextFormField(
                      controller: descTextEditingController,
                      autofocus: true,
                      decoration: InputDecoration(
                        hintText: 'Description',
                        icon: Icon(Icons.note_add),
                      ),
                      maxLength: 150,
                      validator: (text) {
                        return text!.isEmpty
                            ? 'The Field can not be empty'
                            : null;
                      },
                      // validator: MultiValidator([
                      //   RequiredValidator(errorText: 'field must not be empty'),
                      //   MaxLengthValidator(25, errorText: 'Not more than 255 words'),
                      // ]),
                    ),
                    TextFormField(
                      controller: typeTextEditingController,
                      autofocus: true,
                      decoration: InputDecoration(
                        hintText: 'Type(e.g: wedding/birthdays e.t.c)',
                        icon: Icon(Icons.note),
                      ),
                      maxLength: 50,
                      validator: (text) {
                        return text!.isEmpty
                            ? 'The Field can not be empty'
                            : null;
                      },
                      // validator: MultiValidator([
                      //   RequiredValidator(errorText: 'field must not be empty'),
                      //   MaxLengthValidator(25, errorText: 'Not more than 255 words'),
                      // ]),
                    )
                  ],
                ),
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
                onPressed: onPressedSave,
                child: Text(
                  'Create Folder',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                )),
            TextButton(
                onPressed: () {
                  folderTextEditingController!.clear();
                  descTextEditingController!.clear();
                  typeTextEditingController!.clear();
                  Navigator.pop(context);
                },
                child: Text(
                  "Cancel",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ))
          ],
        );
      },
    );
    return showDialog(
        context: context!,
        builder: (_) {
          return alert;
        });
  }

  Future<void> deleteFolder(BuildContext context, VoidCallback onSave) {
    var alert = AlertDialog(
      title: Text(
        'Do You want to Delete This Picture',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 22,
        ),
      ),
      actions: <Widget>[
        TextButton(
            onPressed: onSave,
            // () async {
            //   //ADD A DELETE FUNCTION, INFACT PASS OUT ONPRESSED
            //   Navigator.pop(context);
            // },
            child: Text(
              "Yes",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            )),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            "Cancel",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
        )
      ],
    );
    return showDialog(
        context: context,
        builder: (_) {
          return alert;
        });
  }
}
