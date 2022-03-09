// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:nemycraft_admin/Screens/home_screen/edit_contents.dart';

class EditAboutPage extends StatefulWidget {
  const EditAboutPage({Key? key}) : super(key: key);

  @override
  _EditAboutPageState createState() => _EditAboutPageState();
}

class _EditAboutPageState extends State<EditAboutPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.teal[50],
      appBar: AppBar(title: Text('Edit About'),),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: size.height,
            width: size.width,
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.red)),
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.only(top: 5, bottom: 20),
                  child: RichText(
                    text: TextSpan(
                      text:
                          'This page will basically guide you to edit contents of ',
                      style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                      children: [
                        TextSpan(
                          text: 'About Page ',
                          style: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue.shade200),
                        ),
                        TextSpan(
                          text: 'of the Website',
                        ),
                      ],
                    ),
                  ),
                ),
                //! TODO: ADD LEFT ABOUT IMAGE BY TAKING A SCREENSHOT AND ADDING IT IN COLUMN TO THIS CONTAINER
                HomePageListTiles(
                  containerColor: Colors.yellow[100],
                  title: 'Click Button to edit the "Left About"',
                  buttonText: 'Left_About',
                  size: size,
                  onPressed: () {
                    Navigator.pushNamed(context, '/editLeftAbout');
                  },
                ),
                SizedBox(height: size.height * 0.03),
                //? TODO: ADD RIGHT ABOUT IMAGE BY TAKING A SCREENSHOT AND ADDING IT IN COLUMN TO THIS CONTAINER

                HomePageListTiles(
                  containerColor: Colors.white,
                  title: 'Click Button to edit the "Right About"',
                  buttonText: 'Right_About',
                  size: size,
                  onPressed: () {
                    Navigator.pushNamed(context, '/editRightAbout');
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
