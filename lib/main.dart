// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:nemycraft_admin/Screens/NAVBAR/Events/events_folder.dart';
import 'package:nemycraft_admin/Screens/NAVBAR/Events/image_screen.dart';
import 'package:nemycraft_admin/Screens/NAVBAR/Home/sliding_image.dart';
import 'package:nemycraft_admin/Screens/Reg_Screen/login.dart';
import 'package:nemycraft_admin/Screens/Reg_Screen/sign_up.dart';
import 'package:nemycraft_admin/Screens/NAVBAR/Events/event_screen.dart';
import 'package:nemycraft_admin/Screens/Reg_Screen/start_up.dart';
import 'package:nemycraft_admin/Screens/home_screen/home_screen.dart';
import 'package:nemycraft_admin/Screens/notifications_screen.dart';

import 'Screens/NAVBAR/About/edit_left_about.dart';
import 'Screens/NAVBAR/About/edit_right_about.dart';
import 'Screens/NAVBAR/Home/edit_ads.dart';
import 'Screens/NAVBAR/Home/edit_contact.dart';
import 'Screens/NAVBAR/Home/edit_event.dart';
import 'Screens/NAVBAR/Home/edit_follow.dart';
import 'Screens/NAVBAR/Home/edit_home.dart';
import 'Screens/NAVBAR/Home/edit_sliding.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nemy Admin',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      home:
          // HomeScreen(),
          StartUp(),
      routes: {
        '/login': (context) => LoginPage(),
        '/signUp': (context) => SignUpPage(),
        '/homeScreen': (context) => HomeScreen(),
        '/editHome': (context) => EditHomePage(),
        '/editSliding': (context) => EditSlidingPage(),
        '/editEvents': (context) => EditEventPage(),
        '/editAds': (context) => EditAdsPage(),
        '/editContact': (context) => EditContactPage(),
        '/editFollow': (context) => EditFollowPage(),
        '/editLeftAbout': (context) => EditLeftAboutPage(),
        '/editRightAbout': (context) => EditRightAboutPage(),
        '/eventScreen': (context) => EventScreen(),
        '/notificationsScreen': (context) => NotificationsScreen(),
        '/eventsFolderPage': (context) => EventsFolder(),
        '/imageScreen': (context) => ImageScreen(),
        '/slidingImage': (context) => SlidingImage()
      },
    );
  }
}
