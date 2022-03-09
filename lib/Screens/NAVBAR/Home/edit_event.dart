// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nemycraft_admin/Screens/home_screen/edit_contents.dart';

class EditEventPage extends StatefulWidget {
  const EditEventPage({Key? key}) : super(key: key);

  @override
  _EditEventPageState createState() => _EditEventPageState();
}

class _EditEventPageState extends State<EditEventPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(title: Text('Edit_Events')),
      backgroundColor: Colors.teal[50],
      floatingActionButton: SizedBox(
        height: size.height * 0.15,
        width: size.width * 0.17,
        child: FloatingActionButton(
          onPressed: () {},
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
                  decoration: BoxDecoration(border: Border.all(color: Colors.red)),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
