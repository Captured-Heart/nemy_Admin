// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:nemycraft_admin/Auth/auth_methods.dart';
import 'package:nemycraft_admin/Screens/NAVBAR/Home/components/dialogs.dart';
import 'package:nemycraft_admin/Screens/home_screen/edit_contents.dart';

class EditHomePage extends StatefulWidget {
  const EditHomePage({Key? key}) : super(key: key);

  @override
  _EditHomePageState createState() => _EditHomePageState();
}

class _EditHomePageState extends State<EditHomePage> {
  Dialogs dialogs = Dialogs();
  final AuthMethods _authMethod = AuthMethods();
  Future<bool> _logOut() async {
    dialogs.warningDialog(
        context: context,
        titleText: 'Warning',
        contentText: 'Are you Sure you want to Log out?',
        onPositiveClick: () async {
          await _authMethod.signOut();
          Navigator.popUntil(context, ModalRoute.withName('/'));
        });

    return true;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.teal[50],
      appBar: AppBar(
        title: Text('Edit Home'),
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                TextButton.icon(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.green[300]!)),
                  onPressed: () {
                    _logOut();
                  },
                  icon: Icon(
                    Icons.power_settings_new_outlined,
                    color: Color.fromARGB(255, 255, 81, 0),
                    size: 27,
                  ),
                  label: Text(
                    'Log Out',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
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
                    buttonText: 'Sliding Pics',
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
