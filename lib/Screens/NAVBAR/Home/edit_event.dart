// ignore_for_file: prefer_const_constructors, avoid_print

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nemycraft_admin/Screens/NAVBAR/Events/events_folder.dart';
import 'package:nemycraft_admin/Screens/NAVBAR/Home/components/dialogs.dart';

class EditEventPage extends StatefulWidget {
  const EditEventPage({Key? key}) : super(key: key);

  @override
  _EditEventPageState createState() => _EditEventPageState();
}

class _EditEventPageState extends State<EditEventPage> {
  final Dialogs dialogs = Dialogs();
  final TextEditingController _folderController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();
  final GlobalKey<FormState> _formKeyEditEvent = GlobalKey<FormState>();
  File? _image;
  final bool changeImage = false;
  final picker = ImagePicker();


  chooseImage() async {
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }

    if (pickedFile == null) retrieveLostData();
  }

  Future<void> retrieveLostData() async {
    final LostDataResponse response = await picker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        _image = File(response.file!.path);
      });
    } else {
      // print(response.file);
    }
  }

  @override
  void initState() {
    _folderController.clear();
    _descController.clear();
    _typeController.clear();
    // _image != null ? _image?.delete() : print('there is no image');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: Text('Edit_Events')),
      backgroundColor: Colors.teal[50],
      floatingActionButton: SizedBox(
        height: size.height * 0.15,
        width: size.width * 0.17,
        child: FloatingActionButton(
          onPressed: () {
            dialogs.addFolder(
                context: context,
                folderTextEditingController: _folderController,
                descTextEditingController: _descController,
                typeTextEditingController: _typeController,
                formKeyLeftAbout: _formKeyEditEvent,
                onPressedSave: () {
                  if (_formKeyEditEvent.currentState!.validate()) {
                    try {
                      Navigator.pop(context);
                      // uploadFile(_folderController.text);
                      _image != null
                          ? Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                              return EventsFolder(
                                image: _image,
                                appBarTitle: _folderController.text,
                                descController: _descController.text,
                                typeController: _typeController.text,
                              );
                            }))
                          : dialogs.successDialog(
                              context: context,
                              titleText: 'ERROR',
                              contentText:
                                  'YOU MUST CHOOSE A COVER PIC FOR THIS FOLDER',
                            );
                    } catch (e) {
                      print(e.toString());
                    }
                  }
                });
          },
          tooltip: 'Add/Edit Collection',
          backgroundColor: Colors.blue[300],
          // isExtended: true,
          elevation: 4,
          child: Icon(
            FontAwesomeIcons.folderPlus,
            size: 40,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: size.height,
            width: size.width,
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                Container(
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.red)),
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.only(top: 5),
                  child: Text(
                    'Below is the screenshot of the section from the website, click on the bottom right button to add folders',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                Container(
                  height: size.height * 0.35,
                  width: size.width,
                  margin: EdgeInsets.symmetric(
                    vertical: size.height * 0.04,
                  ),
                  child: Image.asset(
                    'assets/images/nemyEvents.png',
                    fit: BoxFit.cover,
                  ),
                ),
                _image == null
                    ? Text(
                        'click the green "+" button below to add the cover image first for the folder, THEN PROCEED TO CLICK ON THE BOTTOM RIGHT CORNER TO ADD FOLDER',
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.3,
                          fontSize: 18,
                          wordSpacing: 3,
                        ),
                      )
                    : Text(
                        'This will be the cover image for this folder',
                        style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                            fontSize: 21),
                      ),
                SizedBox(
                  height: 4,
                ),
                _image == null
                    ? Container(
                        width: size.width * 0.7,
                        height: size.height * 0.25,
                        decoration: BoxDecoration(
                          border: Border.all(width: 0.4),
                        ),
                        child: IconButton(
                          color: Colors.green,
                          icon: Icon(
                            Icons.add,
                            size: 60,
                          ),
                          onPressed: () {
                            chooseImage();
                          },
                        ),
                      )
                    : Container(
                        width: size.width * 0.7,
                        height: size.height * 0.25,
                        decoration: BoxDecoration(
                          border: Border.all(width: 0.4),
                        ),
                        child: Image.file(
                          _image!,
                          fit: BoxFit.cover,
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
