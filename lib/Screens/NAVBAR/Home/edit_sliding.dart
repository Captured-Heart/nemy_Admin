// ignore_for_file: prefer_const_constructors

import 'dart:io';
import 'dart:math';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nemycraft_admin/Auth/auth_methods.dart';
import 'package:nemycraft_admin/Auth/database.dart';
import 'package:nemycraft_admin/utils.dart';

class EditSlidingPage extends StatefulWidget {
  const EditSlidingPage({Key? key}) : super(key: key);

  @override
  _EditSlidingPageState createState() => _EditSlidingPageState();
}

class _EditSlidingPageState extends State<EditSlidingPage> {
  late String _fileName;
  final FileType _fileType = FileType.custom;
  // final bool _loading = false;
  late FilePickerResult _filePickerResult;
  final bool _multiPick = true;
  List<String> _extension = ['jpg', 'png', 'jpeg'];
  late List<File> _pickedFile;
      List<int> fileSizes = [];

  late int _fileSize;
  AuthMethods authMethods = AuthMethods();
  DataBaseService dataBaseService = DataBaseService();
  Utils utils = Utils();

  void _openFileExplorer() async {
    try {
      _filePickerResult = (await FilePicker.platform.pickFiles(
        type: _fileType,
        allowMultiple: _multiPick,
        allowedExtensions: _extension,
      ))!;
      setState(() {
        if (_filePickerResult.files.length > 1) {
          _pickedFile =
              _filePickerResult.paths.map((path) => File(path!)).toList();
        }
        
        // _pickedFile = File(_filePickerResult.files.single.path.toString());
        _extension = [
        _filePickerResult.files.single.name.toString().split('.').last
      ];
      List<String> fileNames = [];

      _fileName = _filePickerResult.files.single.name;
      fileNames.add(_fileName);
      _fileSize = _filePickerResult.files.single.size;
      fileSizes.add(_fileSize);

      upload(fileName: fileNames, filePath: _pickedFile );
      });
      


    } on PlatformException catch (e) {
      print("Unsupported operation" + e.toString());
    } catch (ex) {
      print(ex);
    }

    if (!mounted) return;
  }

  upload({fileName, filePath}) async {
    // final uuid = await authMethods.getCurrentUID();
    List<String> _downloadUrls = [];

    await Future.forEach(filePath, (image) async {
      Reference ref = FirebaseStorage.instance
          .ref()
          .child('Sliding Images')
          .child(fileName);
      final UploadTask uploadTask = ref.putFile(filePath);
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});

      final String url = await taskSnapshot.ref.getDownloadURL();
      _downloadUrls.add(url);
    });
    // firebase_storage.Reference storageRef = firebase_storage
    //     .FirebaseStorage.instance
    //     .ref()
    //     .child(uuid.toString())
    //     .child(fileName);
    // firebase_storage.UploadTask uploadTask = storageRef.putFile(
    //   filePath,
    // );
    // firebase_storage.TaskSnapshot taskSnapshot =
    //     await uploadTask.whenComplete(() => print('upload complete'));

    // final List<String> url = await taskSnapshot.ref.getDownloadURL();

    Map<String, dynamic> data = {
      'dateCreated': utils.dateFormatted(),
      'fileName': fileName,
      'url': _downloadUrls,
      'fileSize': formatBytes(_fileSize, 2),
      'fileExtension': '.' + _extension.single
    };

    dataBaseService.setSlidingImages(data);
  }

//THE CODE BELOW FORMATS THE BYTE SIZE OF DOCUMENT
  static String formatBytes(int bytes, int decimals) {
    if (bytes <= 0) return "0 KB";
    const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
    var i = (log(bytes) / log(1024)).floor();
    return ((bytes / pow(1024, i)).toStringAsFixed(decimals)) +
        ' ' +
        suffixes[i];
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.teal[50],
      floatingActionButton: FloatingActionButton(
        onPressed: _openFileExplorer,
      ),
      appBar: AppBar(title: Text('Edit_Sliding Images')),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
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
                    'Below is the screenshot of the section from the website',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                Container(
                  height: size.height * 0.4,
                  width: size.width,
                  margin: EdgeInsets.symmetric(
                    vertical: size.height * 0.04,
                  ),
                  child: Image.asset(
                    'assets/images/nemySliding.png',
                    fit: BoxFit.cover,
                  ),
                ),
                //! ADD A FILE PICKER TO PICK IMAGES
              ],
            ),
          ),
        ),
      ),
    );
  }
}
