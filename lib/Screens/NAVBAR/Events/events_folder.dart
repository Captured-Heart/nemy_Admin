// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
// import 'path';
import 'package:path/path.dart' as path;

import '../Home/components/dialogs.dart';

class EventsFolder extends StatefulWidget {
  const EventsFolder({
    Key? key,
    this.appBarTitle,
    this.descController,
    this.typeController,
    this.image,
  }) : super(key: key);
  final String? appBarTitle;
  final String? descController, typeController;
  final File? image;

  @override
  State<EventsFolder> createState() => _EventsFolderState();
}

class _EventsFolderState extends State<EventsFolder> {
  final bool uploading = false;
  late CollectionReference imgRef;
  double val = 0;
  final List<XFile>? _image = [];

  final picker = ImagePicker();
  final Dialogs dialog = Dialogs();

  late DocumentReference addFolderTitle;

  chooseImage() async {
    final List<XFile>? pickedFile = await picker.pickMultiImage();
    if (pickedFile!.isNotEmpty) {
      setState(() {
        _image!.addAll(pickedFile);
      });
    }

    if (pickedFile.isEmpty) retrieveLostData();
  }

  Future<void> retrieveLostData() async {
    final LostDataResponse response = await picker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        _image!.add(response.file!);
      });
    } else {
      // ignore: avoid_print
      print(response.file);
    }
  }

  Future uploadFile(String? folderName) async {
    // int i = 1;

    Reference ref = FirebaseStorage.instance
        .ref()
        .child('Catalogue')
        .child('${widget.appBarTitle}/ coverImage  ${widget.appBarTitle}}');
    // await ref.putFile(_image!).whenComplete(() async {});
    UploadTask uploadTask = ref.putFile(widget.image!);
    TaskSnapshot taskSnapshot =
        await uploadTask.whenComplete(() {}).catchError((error) {
      dialog.warningDialog(
          context: context,
          onPositiveClick: () {
            Navigator.pop(context);
          },
          titleText: 'ERROR',
          contentText: error.toString());
    });

    final String downloadUrl = await taskSnapshot.ref.getDownloadURL();

    for (var img in _image!) {
      // setState(() {
      //   val = i / _image!.length;
      // });
      Reference ref = FirebaseStorage.instance
          .ref()
          .child('Catalogue')
          .child('$folderName/${path.basename(img.path)}');
      var imageloop = File(img.path);
      await ref.putFile(imageloop).whenComplete(
        () async {
          await ref.getDownloadURL().then((value) {
            imgRef.add({
              'url': value,
              'dateCreated': DateTime.now().toString(),
              'Description': widget.descController,
              'type': widget.typeController,
              'folderName': widget.appBarTitle
            });
            addFolderTitle.set({
              'folderName': widget.appBarTitle,
              'coverUrl': downloadUrl,
              'imgLength': _image!.length
            }).whenComplete(() => dialog.pushToDialog(
                  context: context,
                  titleText: 'Success',
                  contentText:
                      'Your files have succesfully been posted to the website',
                ));
          });
        },
      );
    }
  }

  @override
  void initState() {
    super.initState();
    imgRef = FirebaseFirestore.instance
        .collection('Catalogue')
        .doc(widget.appBarTitle)
        .collection('Files');
    addFolderTitle = FirebaseFirestore.instance
        .collection('Catalogue')
        .doc(widget.appBarTitle);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.teal[50],
        appBar: AppBar(
          title: Text(widget.appBarTitle!),
          leading: IconButton(
            onPressed: () {
              setState(() {
                dialog.warningDialog(
                    context: context,
                    titleText: 'PLEASE NOTE',
                    contentText:
                        'You are about to leaving this page to the home Page and no changes will be saved',
                    onPositiveClick: () {
                      Navigator.popUntil(
                          context, ModalRoute.withName('/homeScreen'));

                      // Navigator.pushReplacementNamed(context, '/editHome');
                    });
              });
            },
            icon: Icon(
              Icons.arrow_back,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  SizedBox(
                    width: 50,
                  ),
                  TextButton.icon(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.green)),
                    onPressed: () {
                      uploadFile(widget.appBarTitle);

                      // dialog.pushToDialog(
                      //   context: context,
                      //   titleText: 'Success',
                      //   contentText:
                      //       'Your files have succesfully been posted to the website',
                      //   // pageName: '/editEvents',
                      // );

                      // Navigator.pop(context);
                    },
                    icon: Icon(Icons.upload, color: Colors.amber, size: 30),
                    label: Text(
                      'Upload',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
        body: Stack(
          children: [
            Container(
              padding: EdgeInsets.all(4),
              child: GridView.builder(
                  itemCount: _image!.length + 1,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
                  itemBuilder: (context, index) {
                    return index == 0
                        ? Center(
                            child: Container(
                              width: size.width,
                              height: size.height,
                              decoration: BoxDecoration(
                                border: Border.all(width: 0.4),
                              ),
                              child: IconButton(
                                color: Colors.green,
                                icon: Icon(Icons.add),
                                onPressed: () {
                                  chooseImage();
                                },
                              ),
                            ),
                          )
                        : Padding(
                            padding: EdgeInsets.all(2.0),
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                Image.file(
                                  File(_image![index - 1].path),
                                  fit: BoxFit.cover,
                                ),
                                Positioned(
                                  right: 1,
                                  // top: 2,
                                  child: IconButton(
                                    visualDensity: VisualDensity.compact,
                                    padding: EdgeInsets.zero,
                                    onPressed: () {
                                      setState(() {
                                        _image!.removeAt(index - 1);
                                      });
                                    },
                                    icon: Icon(FontAwesomeIcons.timesCircle),
                                    color: Colors.red,
                                    // size: 30,
                                  ),
                                ),
                              ],
                            ),
                          );
                  }),
            ),
            uploading
                ? Center(
                    child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        child: Text(
                          'uploading...',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CircularProgressIndicator(
                        value: val,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                      )
                    ],
                  ))
                : Container(),
          ],
        ),
      ),
    );
  }
}
