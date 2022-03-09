import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class Utils {
  String dateFormatted() {
    var now = DateTime.now();

    var formatter = DateFormat(" d MMM, yyyy");
    String formatted = formatter.format(now);

    return formatted;
  }
  // void _openFileExplorer() async {
  //   String _fileName;
  // FileType _fileType = FileType.custom;
  // bool _loading = false;
  // FilePickerResult _filePickerResult;
  // bool _multiPick = false;
  // List<String> _extension = ['jpg', 'png', 'jpeg'];
  // File _pickedFile;
  // int _fileSize;

  //   try {
  //     _filePickerResult = (await FilePicker.platform.pickFiles(
  //       type: _fileType,
  //       allowMultiple: _multiPick,
  //       allowedExtensions: _extension,
  //     ))!;
  //     if (_filePickerResult != null) {
  //       setState(() {
  //         _pickedFile = File(_filePickerResult.files.single.path);
  //       });
  //       _extension = [
  //         _filePickerResult.files.single.name.toString().split('.').last
  //       ];

  //       _fileName = _filePickerResult != null
  //           ?
  //           //  truncateString(_filePickerResult.files.single.name, 12)
  //           _filePickerResult.files.single.name
  //           : '...';
  //       _fileSize = _filePickerResult != null
  //           ? _filePickerResult.files.single.size
  //           : 'kkkk';

  //       // _fileExtension = _filePickerResult != null ? _filePickerResult.files.single.extension : '...';

  //       upload(_fileName, _pickedFile);
  //     }
  //   } on PlatformException catch (e) {
  //     print("Unsupported operation" + e.toString());
  //   } catch (ex) {
  //     print(ex);
  //   }

  //   if (!mounted) return;
  // }
}
