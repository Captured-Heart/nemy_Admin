// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nemycraft_admin/Screens/NAVBAR/Events/gridView.dart';
import 'package:nemycraft_admin/Screens/NAVBAR/Events/listView.dart';
import 'package:nemycraft_admin/Screens/home_screen/edit_contents.dart';

class EventScreen extends StatefulWidget {
  const EventScreen({Key? key}) : super(key: key);

  @override
  _EventScreenState createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  // bool viewStyle = true;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(title: Text('Events Screen')),
      backgroundColor: Colors.teal[50],
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
                  child: RichText(
                    text: TextSpan(
                      text:
                          'Below is a list of all the collections you have ever uploaded, ',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                      children: [
                        TextSpan(
                          text:
                              'you can delete any picture in a folder or delete the folder entirely!! ',
                          style: TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                            color: Colors.green.shade300,
                          ),
                        ),
                        TextSpan(
                          text: 'P.S: ONCE DELETED IT CAN NEVER BE RESTORED!',
                          style: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                              color: Colors.red),
                        ),
                      ],
                    ),
                  ),

                  // Text(
                  // 'Below is a list of all the collections you have ever uploaded, you can delete any picture in a folder or delete the folder entirely!!',
                  //   style: TextStyle(
                  //     fontWeight: FontWeight.bold,
                  //     fontSize: 18,
                  //   ),
                  // ),
                ),
                // Container(
                //   height: double.infinity,
                //   width: double.infinity,
                //   child: viewStyle ? GridViewFormat() : ListViewFormat(),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
