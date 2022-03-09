// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nemycraft_admin/Screens/Reg_Screen/start_up.dart';
import 'package:nemycraft_admin/Screens/home_screen/edit_contents.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(title: Text('Notifications')),
      backgroundColor: Colors.teal[50],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: size.width,
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Column(children: [
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
            ]),
          ),
        ),
      ),
    );
  }
}
