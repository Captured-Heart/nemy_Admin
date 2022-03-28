// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

import 'package:nemycraft_admin/Screens/NAVBAR/Home/components/dialogs.dart';
import 'package:path/path.dart' as path;

class EditSlidingPage extends StatefulWidget {
  const EditSlidingPage({Key? key}) : super(key: key);

  @override
  _EditSlidingPageState createState() => _EditSlidingPageState();
}

class _EditSlidingPageState extends State<EditSlidingPage> {
  bool uploading = true;
  late CollectionReference imgRef;
  double val = 0;
  final List<XFile>? _image = [];

  final picker = ImagePicker();
  final Dialogs dialog = Dialogs();

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
      // print(response.file);
    }
  }

  Future uploadFile() async {
    int i = 1;

    for (var img in _image!) {
      setState(() {
        val = i / _image!.length;
      });
      Reference ref = FirebaseStorage.instance
          .ref()
          .child('Sliding/${path.basename(img.path)}');
      var imageloop = File(img.path);
      await ref.putFile(imageloop).whenComplete(() async {
        await ref.getDownloadURL().then((value) {
          imgRef.add({
            'url': value,
            'dateCreated': DateTime.now().toString(),
            // 'Description': widget.descController,
            // 'type': widget.typeController
          });
          i++;
        });
      });
    }
  }

  @override
  void initState() {
    super.initState();
    imgRef = FirebaseFirestore.instance.collection('Sliding');
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.teal[50],
      appBar: AppBar(
        title: Text('Edit_Sliding Images'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                TextButton.icon(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.green)),
                  onPressed: () {
                    uploadFile();
                    _image!.isEmpty
                        ? dialog.warningDialog(
                            context: context,
                            titleText: 'ERROR',
                            contentText:
                                'You have not selected any image and therefore can not upload empty files, use the "+" button to pick an image',
                            onPositiveClick: () {
                              Navigator.pop(context);
                            },
                          )
                        : dialog.popUntil2Dialog(
                            context: context,
                            titleText: 'Success',
                            onNegativeClick: () {
                              // _image!.remove(true);
                              setState(() {
                                _image!.clear();
                                Navigator.of(context).popAndPushNamed('/slidingImage');
                              });
                            },
                            contentText:
                                'Your files have succesfully been posted to the website',
                          );
                    // Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.upload,
                    color: Colors.amber,
                    size: 25,
                  ),
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
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Container(
                width: size.width,
                height: size.height * 0.5,
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    Container(
                      decoration:
                          BoxDecoration(border: Border.all(color: Colors.red)),
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.only(top: 5),
                      child: Text(
                        'Below is the screenshot of the section from the website',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Container(
                      height: size.height * 0.3,
                      width: size.width,
                      margin: EdgeInsets.symmetric(
                        vertical: size.height * 0.04,
                      ),
                      child: Image.asset(
                        'assets/images/nemySliding.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    // Icon(Icons.folder),
                    //! ADD A FILE PICKER TO PICK IMAGES
                  ],
                ),
              ),
              Stack(
                // fit: StackFit.expand,
                children: [
                  Container(
                    height: size.height * 0.6,
                    padding: EdgeInsets.all(4),
                    child: GridView.builder(
                        itemCount: _image!.length + 1,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3),
                        itemBuilder: (context, index) {
                          return index == 0
                              ? Center(
                                  child: Container(
                                    margin: EdgeInsets.only(
                                      left: 5,
                                      right: 5,
                                    ),
                                    width: size.width,
                                    height: size.height,
                                    decoration: BoxDecoration(
                                      border: Border.all(width: 0.5),
                                    ),
                                    child: IconButton(
                                      color: Colors.green,
                                      icon: Icon(
                                        Icons.add,
                                        size: 50,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          uploading = false;
                                        });
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
                                          icon: Icon(
                                              FontAwesomeIcons.timesCircle),
                                          color: Colors.red,
                                          // size: 30,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                        }),
                  ),
                  Visibility(
                    visible: uploading,
                    child: Align(
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          InkWell(
                            onTap: (){
                              Navigator.pushNamed(context, '/slidingImage');
                            },
                            child: Icon(
                              Icons.folder,
                              size: size.width * 0.3,
                              color: Colors.blue,
                            ),
                          ),
                          Text(
                            'Sliding Images Folder',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // uploading
                  //     ? Center(
                  //         child: Column(
                  //         mainAxisSize: MainAxisSize.min,
                  //         children: [
                  //           SizedBox(
                  //             child: Text(
                  //               'uploading...',
                  //               style: TextStyle(fontSize: 20),
                  //             ),
                  //           ),
                  //           SizedBox(
                  //             height: 10,
                  //           ),
                  //           CircularProgressIndicator(
                  //             value: val,
                  //             valueColor:
                  //                 AlwaysStoppedAnimation<Color>(Colors.green),
                  //           )
                  //         ],
                  //       ))
                  //     : Container(),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
