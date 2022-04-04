// ignore_for_file: prefer_const_constructors

import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nemycraft_admin/Auth/auth_methods.dart';
import 'package:nemycraft_admin/Screens/NAVBAR/About/edit_about.dart';
import 'package:nemycraft_admin/Screens/NAVBAR/Home/edit_home.dart';
import 'package:nemycraft_admin/Screens/NAVBAR/Events/event_screen.dart';
import 'package:nemycraft_admin/Screens/notifications_screen.dart';

import '../NAVBAR/Home/components/dialogs.dart';
// import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController();
  final AuthMethods _authMethod = AuthMethods();
  Dialogs dialogs = Dialogs();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: ConvexAppBar(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 5,
        height: size.height * 0.08,
        items: const [
          TabItem(icon: Icons.home, title: 'Home'),
          TabItem(icon: FontAwesomeIcons.pencilAlt, title: 'About'),
          TabItem(icon: Icons.folder, title: 'Events'),
          TabItem(icon: Icons.contact_page, title: 'Notifications'),
        ],
        onTap: (index) {
          _pageController.animateToPage(
            index,
            duration: Duration(milliseconds: 600),
            curve: Curves.fastLinearToSlowEaseIn,
          );
        },
      ),
      body: WillPopScope(
        onWillPop: () => _logOut(),
        child: SafeArea(
          child: PageView(
            physics: NeverScrollableScrollPhysics(),
            controller: _pageController,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              EditHomePage(),
              EditAboutPage(),
              EventScreen(),
              NotificationsScreen()
            ],
          ),
        ),
      ),
    );
  }

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
}
