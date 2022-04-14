// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nemycraft_admin/Screens/NAVBAR/Events/enlarge_image.dart';
import 'package:nemycraft_admin/Screens/NAVBAR/Home/components/dialogs.dart';
import 'package:path/path.dart' as path;

class ImageScreen extends StatefulWidget {
  const ImageScreen({Key? key, this.appBarTitle}) : super(key: key);
  final String? appBarTitle;

  @override
  State<ImageScreen> createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
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
      uploadFile(widget.appBarTitle);
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

    // // Reference ref = FirebaseStorage.instance
    // //     .ref()
    // //     .child('Catalogue')
    // //     .child('${widget.appBarTitle}/ coverImage  ${widget.appBarTitle}}');
    // // // await ref.putFile(_image!).whenComplete(() async {});
    // // UploadTask uploadTask = ref.putFile(widget.image!);
    // TaskSnapshot taskSnapshot =
    //     await uploadTask.whenComplete(() {}).catchError((error) {
    //   dialog.warningDialog(
    //       context: context,
    //       onPositiveClick: () {
    //         Navigator.pop(context);
    //       },
    //       titleText: 'ERROR',
    //       contentText: error.toString());
    // });

    // final String downloadUrl = await taskSnapshot.ref.getDownloadURL();

    for (var img in _image!) {
      // setState(() {
      //   val = i / _image!.length;
      // });

      //! CHECK THE PATH ON FIREBASE STORAGE
      //? THEN CHANGE THE METHOD OF PICKING FOLDERtITLE ON WEBSITE(SNAPSHOT.DATA.DOC.FIRST IS WRONG ON THE WEBISTE)
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
              'folderName': widget.appBarTitle
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
    getImages();
    imgRef = FirebaseFirestore.instance
        .collection('Catalogue')
        .doc(widget.appBarTitle)
        .collection('Files');
    addFolderTitle = FirebaseFirestore.instance
        .collection('Catalogue')
        .doc(widget.appBarTitle);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.teal[50],
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            child: Text(
              'Add Pics',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
            color: Colors.pink[400],
            padding: EdgeInsets.all(5),
          ),
          SizedBox(
            height: 2,
          ),
          FloatingActionButton(
            onPressed: () {
              chooseImage();
              // uploadFile(widget.appBarTitle);
            },
            child: Icon(
              Icons.add,
              size: 35,
            ),
            tooltip: 'Add pics to this collection',
          ),
        ],
      ),
      appBar: AppBar(
        title: Text(widget.appBarTitle!),
      ),
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: StreamBuilder(
            stream: getImages(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              var nothingDae = !snapshot.hasData;

              return nothingDae
                  ? Center(
                      child: CircularProgressIndicator(),
                      // child: Text('There are no pictures available/ Kindly check your Internet connection'),
                    )
                  : GridView(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                      ),
                      children: snapshot.data!.docs.map(
                        (documents) {
                          Future delete(context) async {
                            final doc = FirebaseFirestore.instance
                                .collection('Catalogue')
                                .doc(widget.appBarTitle)
                                .collection('Files')
                                .doc(documents.id);

                            return await doc.delete();
                          }

                          Dialogs dialogs = Dialogs();
                          return Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: InkWell(
                              onTap: () {
                                // print(documents['url']);

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return EnlargeScreen(
                                        url: documents['url'],
                                        appBarTitle: '',
                                      );
                                    },
                                  ),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Stack(
                                  fit: StackFit.expand,
                                  children: [
                                    Image.network(
                                      documents['url'],
                                      fit: BoxFit.cover,
                                    ),
                                    Positioned(
                                      right: 2,
                                      top: 2,
                                      child: IconButton(
                                        visualDensity: VisualDensity.compact,
                                        padding: EdgeInsets.zero,
                                        alignment: Alignment.topRight,
                                        onPressed: () {
                                          setState(() {
                                            dialogs.deleteFolder(
                                              context,
                                              () {
                                                delete(context);
                                                Navigator.pop(context);
                                              },
                                              'Do You want to Delete This Picture',
                                            );
                                            // _image!.removeAt(index - 1);
                                          });
                                        },
                                        icon: Icon(
                                          FontAwesomeIcons.timesCircle,
                                          size: 32,
                                        ),
                                        color: Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // Image.network(
                              //   documents['url'],
                              //   fit: BoxFit.cover,
                              // ),
                            ),
                          );
                        },
                      ).toList(),
                    );
            }),
      ),
    );
  }

  Stream<QuerySnapshot> getImages() async* {
    yield* FirebaseFirestore.instance
        .collection('Catalogue')
        .doc(widget.appBarTitle)
        .collection('Files')
        .snapshots();
  }
}
