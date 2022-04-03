// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:nemycraft_admin/Screens/home_screen/edit_contents.dart';

class EditHomePage extends StatefulWidget {
  const EditHomePage({Key? key}) : super(key: key);

  @override
  _EditHomePageState createState() => _EditHomePageState();
}

class _EditHomePageState extends State<EditHomePage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.teal[50],
      appBar: AppBar(
        title: Text('Edit Home'),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: size.height,
            width: size.width,
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.red)),
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'This page will basically guide you to edit contents of Home Page on the website',
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  HomePageListTiles(
                    containerColor: Colors.yellow[100],
                    title: 'Click Button to edit the sliding images',
                    buttonText: 'Sliding Images',
                    size: size,
                    onPressed: () {
                      Navigator.pushNamed(context, '/editSliding');
                      // Navigator.of(context).pushNamed('/editSliding');
                    },
                  ),
                  HomePageListTiles(
                    containerColor: Colors.white,
                    title: 'Click to add/delete Events Collection',
                    buttonText: 'Events Gallery',
                    size: size,
                    onPressed: () {
                      Navigator.pushNamed(context, '/editEvents');
                    },
                  ),
                  HomePageListTiles(
                    containerColor: Colors.yellow[100],
                    size: size,
                    title: 'Click to edit Blue/Ads Section',
                    buttonText: 'Ads Section',
                    onPressed: () {
                      Navigator.pushNamed(context, '/editAds');
                    },
                  ),
                  HomePageListTiles(
                    containerColor: Colors.white,
                    size: size,
                    title: 'Click to edit Contact Us Section',
                    buttonText: 'Contact Us',
                    onPressed: () {
                      Navigator.pushNamed(context, '/editContact');
                    },
                  ),
                  HomePageListTiles(
                    containerColor: Colors.yellow[100],
                    size: size,
                    title: 'Click to Add your social media profile links',
                    buttonText: 'Follow Us',
                    onPressed: () {
                      Navigator.pushNamed(context, '/editFollow');
                    },
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
